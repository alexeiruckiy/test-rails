class DocumentsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @documents, root: false
  end

  def show
    render json: @document
  end

  def create
    DocumentBuilder.new(@document).create_blank!
    render json: @document, status: :created
  end

  def update
    @document.update!(document_params)
    WebsocketRails[:document].trigger 'change', @document
    render json: {}, status: :ok
  end

  private
  def document_params
    params.permit(:name, :description).merge(user: current_user)
  end

end
