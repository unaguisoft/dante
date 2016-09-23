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

  # Verifica si el usuario está logueado y tiene el rol
  def is?(role)
    logged_in? && current_user.is?(role)
  end
  # Verifica si el usuario es admin
  def only_authorize_admin!
    authorize!(is?(:admin))
  end

  def authorize!(condition,
                 msg = 'No tenés los permisos necesarios para acceder a esta página.')
    unless condition
      raise NotAuthorized, msg
    end
  end
end
