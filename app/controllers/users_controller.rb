class UsersController < ApplicationController
  #before_action :restrict_access, only: [:show]
  load_and_authorize_resource

  def show
    render json: @user, only: [:id, :name, :email]
  end

end
