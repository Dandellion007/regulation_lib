class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit raw_edit archive update destroy]
  before_action :check_user_is_admin, except: %i[index show search_index]

  def index
    if params.key?(:search)
      @documents = Document.search(search_params)
      @designation = search_params[:designation]
    else
      @documents = Document.search({})
      @designation = ''
    end
  end

  def show; end

  def new
    @document = Document.new
  end

  def edit; end

  def raw_edit; end

  def archive
    @document = DocumentService.new.archive(@document)
    if @document.errors.empty?
      redirect_to document_url(@document), notice: "Документ архивирован."
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def archive_index
    @documents = Document.archived
  end

  def search_index
    if params.key?(:search)
      @documents = Document.search(search_params)
      @search_params = search_params
    else
      @documents = Document.search({})
    end
  end

  def create
    debugger

    @document = DocumentService.new.create(document_params, reference_params)
    if @document.errors.empty?
      redirect_to document_url(@document), notice: "Документ успешно создан."
    else
      @fail_field = @document.errors.messages.keys[0]
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @document = DocumentService.new.update(document_params, @document)
    if @document.errors.empty?
      redirect_to document_url(@document), notice: "Документ успешно обновлен."
    else
      @fail_field = @document.errors.messages.keys[0]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Документ успешно удален." }
      format.json { head :no_content }
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(Document.all_fields)
  end

  def reference_params
    params.permit(reference: [])
  end

  def search_params
    params.require(:search).permit(Document.search_fields)
  end

  def check_user_is_admin
    redirect_to documents_url and return unless current_user.admin?
  end
end
