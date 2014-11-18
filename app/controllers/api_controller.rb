class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Cookies
  include ActionController::MimeResponds

  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

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

  def record_not_found (e)
     render json: {
        msg: 'Record not found'
     }, status: 404
  end


  private
  def restrict_access
    unless restrict_access_by_params || restrict_access_by_header
      render json: {
          msg: 'Invalid API Token'
      }, status: 401
      return
    end

    @current_user = @api_key.user if @api_key
  end

  def restrict_access_by_header
    return true if @api_key

    authenticate_with_http_token do |token|
      @api_key = ApiKey.find_by_token(token)
    end
  end

  def restrict_access_by_params
    return true if @api_key

    @api_key = ApiKey.find_by_token(request.env['HTTP_TOKEN'])
  end

  def current_user
    @current_user
  end

end