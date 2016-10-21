class PhotosController < ApplicationController

  include PropertyScoped
  
  def create
    @photo = @property.photos.build(photo_params)
    @photo.save!
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy!
  end

  private

  def photo_params
    params.require(:photo).permit(:file)
  end

end

