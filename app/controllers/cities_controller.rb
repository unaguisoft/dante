class CitiesController < ApplicationController
  
  before_action :set_city, only: [:edit, :update, :destroy]
  
  def index
    @cities = City.all
  end
  
  def new
    @city = City.new
  end
  
  def edit
  end
  
  def create
    @city = City.new(city_params)
    
    respond_to do |format|
      if @city.save
        format.json { render json: { result: 'success', data: @city } } 
        format.html { redirect_to :cities, 
          notice: 'La característica ha sido creada correctamente.' 
        }
      else
        format.json { 
          render json: 
            { 
              result: 'error', 
              error_messages: @city.errors, 
              full_error_messages: @city.errors.full_messages
            } 
        }
        format.html { render :new }
      end
    end
  end
  
  def update
    if @city.update(city_params)
      redirect_to :cities, 
        notice: 'La característica ha sido actualizada correctamente.'
    else
      flash[:error] = 'Falló al actualizar la característica.'
      render :edit
    end
  end
  
  def destroy
    if @city.destroy
      redirect_to :cities, 
        notice: 'La característica ha sido eliminada correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar la característica'
      redirect_to :cities
    end
  end
  
  private
  
  def city_params
    params.require(:city).permit(:name)
  end
  
  def set_city
    @city = City.find(params[:id])
  end

end
