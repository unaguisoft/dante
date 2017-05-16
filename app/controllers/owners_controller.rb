class OwnersController < ApplicationController
  
  before_action :set_owner, only: [:edit, :update, :destroy]
  
  def index
    @presenter = OwnerPresenter.new(current_user: current_user, params: params)
  end
  
  def new
    @modal_form = params[:modal] || false
    @owner = Owner.new(agent: current_user)
    if @modal_form
      render :new, layout: nil
    else
      render :new
    end
  end
  
  def edit
  end
  
  def create
    @owner = Owner.new(owner_params)
    
    respond_to do |format|
      if @owner.save
        format.json { render json: { result: 'success', data: @owner } } 
        format.html { redirect_to :owners, 
          notice: 'El propietario ha sido creado correctamente.' 
        }
      else
        format.json { 
          render json: 
            { 
              result: 'error', 
              error_messages: @owner.errors, 
              full_error_messages: @owner.errors.full_messages
            } 
        }
        format.html { render :new }
      end
    end
  end
  
  def update
    if @owner.update(owner_params)
      redirect_to :owners, 
        notice: 'El propietario ha sido actualizado correctamente.'
    else
      flash[:error] = 'Falló al actualizar el propietario.'
      render :edit
    end
  end
  
  def destroy
    if @owner.destroy
      redirect_to :owners, 
        notice: 'El propietario ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el propietario'
      redirect_to :owners
    end
  end
  
  def search
    block = ->(owner) { { id: owner.id, name: owner.to_s } }
    records = RecordSearcher.call(Owner.all, params, &block)
    render json: records.to_json, callback: params[:callback]
  end
  
  private
  
  def owner_params
    params.require(:owner).permit(:first_name, :last_name, :email, :agent_id, :phones, :cellphone)
  end
  
  def set_owner
    @owner = Owner.find(params[:id])
  end

end
