class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApiHelper
  def new
    set_user_params_in_cookie
    render 'index'
  end
end
