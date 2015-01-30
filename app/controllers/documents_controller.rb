class DocumentsController < ApplicationController
  load_and_authorize_resource

  def create
    render json: @document.tap{|document| document.save!}, only: [:id]
  end

  def show
    render json: @document, except: [:created_at, :updated_at]
  end

  def update
    @document.update!(document_params)
    render json: {}
  end

  private
  def document_params
    params.permit(:name, :description).merge(user: current_user)
  end

end
