module Api
  module V1
    class ValidationsController < ApiController
      def index
        json = Jbuilder.encode do |json|
          json.array! Validation.joins(:entity) do |validation|
            json.id validation.id
            json.field validation.field
            json.rule validation.rule
            json.message validation.message
            json.entity validation.entity.name
          end
        end
        render json: json
      end

    end
  end
end
