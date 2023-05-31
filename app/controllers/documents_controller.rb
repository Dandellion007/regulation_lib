class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit raw_edit archive update destroy]

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

  def create
    @document = DocumentService.new.create(document_params)
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
      render json: {path: document_url(@document), notice: "Документ успешно обновлен."}
    else
      render json: @document.errors, status: :unprocessable_entity
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

  def search_params
    params.require(:search).permit(Document.search_fields)
  end
end
