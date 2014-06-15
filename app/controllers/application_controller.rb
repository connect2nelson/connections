class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    session[:auth_token]
  end

  def logged_in?
    !session[:auth_token].nil?
  end

  def is_authorized
    enabled_security = ENV["SECURITY_ENABLED"] == "ENABLED"
    current_user != nil || (enabled_security == false)
  end


  def authenticate_user
    if(!is_authorized)
      redirect_to "/auth/saml"
    end
  end
end
