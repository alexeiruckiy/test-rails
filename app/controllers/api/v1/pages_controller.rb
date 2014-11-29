class Api::V1::PagesController < Api::V1::ApiController
  before_action :restrict_access

  def index
    document = Document.includes(:pages).find params[:document_id]
    render json: document.pages, only: [:id, :content]
  end

  def show
    render json: Page.find(params[:id]), only: [:id, :content]
  end

  def create
    document = Document.find id: params[:document_id]
    if document
      render json: Page.create(page_params), only: [:id]
    else
      render json: {
          msg: 'Document not found'
      }, status: 404
    end
  end

  def update
    Page.update params[:id], page_params
    render json: {}
  end

  private
  def page_params
    params.permit(:content, :document_id)
  end

end
