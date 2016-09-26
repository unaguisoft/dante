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
    @property            = Property.new(property_params)
    @property.user       = current_user
    @property.total_area = @property.built_area + @property.semi_built_area

    if @property.save
      # TODO: crear features
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
    params.require(:property).permit(:kind, :status, :price, :currency, 
            :should_display_price, :expenses_cost, :property_status, 
            :property_kind, :year, :number_of_floors, :built_area,
            :semi_built_area, :total_area, :perimeter, :has_parking,
            :address, :description, :title, :number_of_rooms,
            :number_of_bedrooms, :number_of_bathrooms, :number_of_toilets,
            :should_display_on_web, :should_highlight_on_web, :city_id,
            :owner_id, :user_id, property_feature_ids: []) if params[:property].present?
  end
  
  def set_property
    @property = Property.find(params[:id])
  end

end
