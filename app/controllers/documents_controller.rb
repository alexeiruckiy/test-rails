class DocumentsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @documents, except: [:updated_at]
  end

  def show
    render json: @document, except: [:updated_at]
  end

  def create
    render json: @document.tap{|document| document.save!}, only: [:id]
  end

  def update
    @document.update!(document_params)
    render json: {}
  end

  def count

  end

  private
  def document_params
    params.permit(:name, :description).merge(user: current_user)
  end

end
