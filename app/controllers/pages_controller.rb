class PagesController < ApplicationController
  load_and_authorize_resource :document
  load_and_authorize_resource :page, through: :document, shallow: true

  def index
    render json: @pages, only: [:id, :content, :document_id]
  end

  def show
    render json: @page, only: [:id, :content, :document_id]
  end

  def create
    render json: @page.tap {|page| page.save!}, only: [:id]
  end

  def update
    @page.update(page_params)
    render json: {}
  end

  private
  def page_params
    params.permit(:content, :document_id)
  end

end
