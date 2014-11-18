module Api
  module V1
    class DocumentsController < ApiController
      before_action :restrict_access, only: [:create, :show]

      def create
        @document = Document.create_document document_params.merge(user: @current_user)
        render json: {
            id: @document.id
        }
      end

      def show
        @document = Document.find params[:id]
        render json: @document, except: [:created_at, :updated_at]
      end

      def update
        Document.update params[:id], document_params
        render json: {}
      end

      private
      def document_params
        params.permit(:name, :description)
      end

    end
  end
end