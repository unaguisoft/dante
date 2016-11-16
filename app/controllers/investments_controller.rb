class InvestmentsController < ApplicationController

  before_action :set_investment, only: [:edit, :update, :destroy, :upload_investment_photos]
  
  def index
    @presenter = InvestmentPresenter.new(params)
  end

  def new
    @investment = Investment.new
  end

  def edit
  end

  def create
    @investment = Investment.new(investment_params)

    if @investment.save
      redirect_to upload_investment_photos_investment_path(@investment), 
        notice: 'La inversión ha sido creada correctamente. Seleccione las imágenes.'
    else
      flash[:error] = 'Ups, ocurrió un error al intentar guardar la inversión.'
      render :new
    end
  end

  def update
    if @investment.update(investment_params)
      redirect_to :investments,
        notice: 'La inversión ha sido actualizada correctamente.'
    else
      flash[:error] = 'Ups, ocurrió un error al intentar actualizar la inversión.'
      render :edit
    end
  end

  def destroy
    if @investment.destroy
      redirect_to :investments,
        notice: 'La inversión ha sido eliminada correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar la inversión'
      redirect_to :investments
    end
  end
  
  def upload_investment_photos
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'La inversión buscada no existe'
      redirect_to investments_path
  end

  private

  def investment_params
    params.require(:investment).permit(:title, :details, :address, 
                    :should_display_on_web) if params[:investment].present?
  end

  def set_investment
    @investment = Investment.find(params[:id])
  end

end
