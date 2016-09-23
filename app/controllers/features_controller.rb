class FeaturesController < ApplicationController
  
  before_action :set_feature, only: [:edit, :update, :destroy]
  
  def index
    @features = Feature.all
  end
  
  def new
    @feature = Feature.new
  end
  
  def edit
  end
  
  def create
    @feature = Feature.new(feature_params)
    
    respond_to do |format|
      if @feature.save
        format.json { render json: { result: 'success', data: @feature } } 
        format.html { redirect_to :features, 
          notice: 'La característica ha sido creada correctamente.' 
        }
      else
        format.json { 
          render json: 
            { 
              result: 'error', 
              error_messages: @feature.errors, 
              full_error_messages: @feature.errors.full_messages
            } 
        }
        format.html { render :new }
      end
    end
  end
  
  def update
    if @feature.update(feature_params)
      redirect_to :features, 
        notice: 'La característica ha sido actualizada correctamente.'
    else
      flash[:error] = 'Falló al actualizar la característica.'
      render :edit
    end
  end
  
  def destroy
    if @feature.destroy
      redirect_to :features, 
        notice: 'La característica ha sido eliminada correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar la característica'
      redirect_to :features
    end
  end
  
  private
  
  def feature_params
    params.require(:feature).permit(:name)
  end
  
  def set_feature
    @feature = Feature.find(params[:id])
  end

end
