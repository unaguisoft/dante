class PropertiesController < ApplicationController
  
  before_action :set_property, only: [:edit, :update, :destroy]
  
  def index
    @presenter = PropertyPresenter.new(params)
  end
  
  def new
    @property = Property.new(user: current_user)
  end
  
  def edit
  end
  
  def create
    @property = Property.new(property_params)
    @property.total_area = @property.built_area + @property.semi_built_area
    
    if @property.save
      redirect_to :properties, notice: 'La propiedad ha sido creada correctamente.' 
    else
      flash[:error] = 'Ups, ocurrió un error al intentar guardar la propiedad.'
      render :new
    end
  end
  
  def update
    if @property.update(property_params)
      redirect_to :properties, 
        notice: 'La propiedad ha sido actualizada correctamente.'
    else
      flash[:error] = 'Ups, ocurrió un error al intentar actualizar la propiedad.'
      render :edit
    end
  end
  
  def destroy
    if @property.destroy
      redirect_to :properties, 
        notice: 'La propiedad ha sido eliminada correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar la propiedad'
      redirect_to :properties
    end
  end
  
  private
  
  def property_params
    params.require(:property).permit(:name)
  end
  
  def set_property
    @property = Property.find(params[:id])
  end

end
