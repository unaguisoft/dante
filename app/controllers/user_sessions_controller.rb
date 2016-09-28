class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  layout 'prelogin'

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:root, notice: 'Ha iniciado sesión exitosamente')
    else
      flash[:error] = 'Combinación de usuario y clave incorrecta'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: 'Ha cerrado sesión exitosamente'
  end
end
