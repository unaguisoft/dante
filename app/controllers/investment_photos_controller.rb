class InvestmentPhotosController < ApplicationController

  include InvestmentScoped
  
  def create
    @investment_photo = @investment.investment_photos.build(investment_photo_params)
    @investment_photo.save!
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @investment_photo = InvestmentPhoto.find(params[:id])
    @investment_photo.destroy!
  end

  private

  def investment_photo_params
    params.require(:investment_photo).permit(:file)
  end

end

