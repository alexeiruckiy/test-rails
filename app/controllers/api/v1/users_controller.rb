class Api::V1::UsersController < Api::V1::ApiController
  #before_action :restrict_access, only: [:show]

  def show
    user = User.find params[:id]
    render json: {
        id: user.id,
        name: user.name,
        email: user.email
    }
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
