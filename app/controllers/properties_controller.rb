class PropertiesController < ApplicationController

  before_action :set_property, only: [:edit, :show, :update, :destroy, :upload_photos]

  def index
    @presenter = PropertyPresenter.new(params, current_user)
  end

  def show
    respond_to do |format|
      format.pdf do
        pdf = PropertyPdf.new(@property, view_context)
        send_data pdf.render,
          filename: "dante_estudio_inmobiliario_#{@property.id}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end
    end
  end

  def new
    @property = Property.new(user: current_user)
  end

  def edit
  end

  def create
    @property      = Property.new(property_params)
    @property.user = current_user

    if @property.save
      redirect_to upload_photos_property_path(@property), notice: 'La propiedad ha sido creada correctamente. Seleccione las imágenes.'
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

  def upload_photos
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'La propiedad buscada no existe'
      redirect_to properties_path
  end

  private

  def property_params
    params.require(:property).permit(:kind, :status, :price, :currency,
            :should_display_price, :expenses_cost, :property_status,
            :property_kind, :year, :number_of_floors, :built_area,
            :semi_built_area, :total_area, :perimeter, :open_area,
            :address, :description, :title, :number_of_rooms, :bankable,
            :number_of_bedrooms, :number_of_bathrooms, :number_of_toilets,
            :should_display_on_web, :should_highlight_on_web, :city_id,
            :google_maps_address,
            :owner_id, :user_id, feature_ids: []) if params[:property].present?
  end

  def set_property
    @property = Property.find(params[:id])
  end

end
