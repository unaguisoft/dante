class UsersController < ApplicationController

  before_action :only_authorize_admin!, except: [:edit, :update]
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users
  def index
    @presenter = UsersPresenter.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'El usuario ha sido creado correctamente.'
    else
      render :new
    end
  end

  # GET /users/:id/edit
  def edit
    authorize!(is_me? || is?(:admin))
  end

  # PUT /users/:id
  def update
    authorize!(is_me? || is?(:admin))

    if @user.update(user_params)
      redirect_to (is?(:admin) ? users_path : root_path), notice: 'El usuario ha sido actualizado correctamente.'
    else
      flash.now[:error] = 'Ocurrió un error al actualizar el usuario.'
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    avoid_destroy_if_me && destroy_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def is_me?
    current_user == @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :role,
                                 :password_confirmation)
  end

  def avoid_destroy_if_me
    return true unless is_me?
    flash[:error] = 'No podés eliminarte a vos mismo'
    redirect_to users_path
    return false
  end

  def destroy_user
    if @user.destroy
      redirect_to users_path, notice: 'El usuario ha sido eliminado correctamente'
      return true
    else
      flash[:error] = 'El usuario no ha podido ser eliminado'
      redirect_to users_path
      return false
    end
  end

end
