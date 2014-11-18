module Api
  module V1
    class SessionsController < ApiController

      def create
        user = User.find_by_name params[:name]
        if user and user.authenticate(params[:password])
          session[:user_id] = user.id
          render json: {
              id: user.id,
              token: user.api_key.token
          }
        else
          if user
            json = [{
                msg: 'Wrong password',
                field: 'password'
            }]
          else
            json = [{
                msg: 'Name no found',
                field: 'name'
            }]
          end
          render json: json, status: 403
        end
      end

      def destroy
        reset_session
      end

    end
  end
end
