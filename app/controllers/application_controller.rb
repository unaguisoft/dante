class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  class NotAuthorized < StandardError
  end
  rescue_from NotAuthorized, with: :not_authorized

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  private

  # Usuario no autorizado
  def not_authorized(exception)
    respond_to do |format|
      format.html {
        flash[:error] = exception.to_s
        redirect_to login_path
      }
      format.js {
        head :forbidden
      }
    end
  end

  def not_authenticated
    flash[:notice] = 'Por favor inicia sesión'
    redirect_to login_path
  end
end
