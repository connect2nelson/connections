class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user	

  def create
    session[:auth_token] = request.env['omniauth.auth']
    redirect_to '/'
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
