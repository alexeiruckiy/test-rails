module ApiHelper
  def setup_user_params_in_session(user)
    warden.session(:user)['user_id'] = user.id
    warden.session(:user)['api_token'] = user.api_key.token
  end

  def set_user_params_in_cookie
    if warden.authenticate? scope: :user
      cookies[:user_id] = warden.session(:user)['user_id']
      cookies[:api_token] = warden.session(:user)['api_token']
      true
    end
    false
  end
end