class SessionsController < Devise::SessionsController
  skip_before_filter :verify_signed_out_user, only: :destroy
# before_filter :configure_sign_in_params, only: [:create]

# GET /resource/sign_in
# def new
#   super
# end

# POST /resource/sign_in
  def create
    user = User.find_for_database_authentication(name: params[:name])
    unless user && user.confirmed?
      return render json: [
          {
              msg: 'Name no found',
              field: 'name'
          }
      ], status: 403
    end
    if user.valid_password?(params[:password])
      sign_in(:user, user)
      cookies[:user_id] = user.id
      render json: {
          id: user.id,
          token: user.api_key.token
      }
    else
      render json: [
          {
              msg: 'Wrong password',
              field: 'password'
          }
      ], status: 403
    end

  end

  #DELETE /resource/sign_out
  def destroy
    sign_out(:user)
    cookies.delete('user_id')
    render nothing: true
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
