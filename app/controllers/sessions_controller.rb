class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    session[:auth_token] = request.env['omniauth.auth']
    redirect_to '/'
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
