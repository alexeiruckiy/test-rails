module Api
  module V1
    class UsersController < ApiController
      before_action :restrict_access, only: [:show]

      def create
        User.create! user_params
        render json: {}, status: 200
      end


      def show
        @user = User.find params[:id]
        ret = Jbuilder.encode do |json|
          json.id @user.id
          json.name @user.name
          json.email @user.email
        end
        render json: ret
      end

      private
      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

    end
  end
end
