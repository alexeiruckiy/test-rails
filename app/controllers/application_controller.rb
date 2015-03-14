class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  #include Devise::Controllers::Helpers::ClassMethods
  def new
    if current_user
      cookies[:user_id] = current_user.id
    else
      cookies.delete('user_id')
    end
    render 'index'
  end

  protected
  def record_invalid (e)
    json = Jbuilder.encode do |json|
      json.array! e.record.errors.messages do |message|
        json.field message[0]
        json.msg message[1][0]
      end
    end
    render json: json, status: 403
  end

  def record_not_found
    render json: {
        msg: 'Record not found'
    }, status: 404
  end

end
