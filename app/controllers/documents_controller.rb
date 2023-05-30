class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit raw_edit update destroy]

  def index
    @documents = Document.all
  end

  def show; end

  def new
    @document = Document.new
  end

  def edit; end

  def raw_edit; end

  def create
    @document = DocumentService.new.create(document_params)
    respond_to do |format|
      if @document.errors.empty?
        format.html { redirect_to document_url(@document), notice: "Документ успешно создан." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    document = DocumentService.new.update(document_params, @document)
    respond_to do |format|
      if document.errors.empty?
        format.html { redirect_to document_url(@document), notice: "Документ успешно обновлен." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
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
end
