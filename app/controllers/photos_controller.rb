class PhotosController < ApplicationController
  before_action :set_photo, only: [:destroy, :update]


  include PropertyScoped
  
  def create
    @photo = @property.photos.build(photo_params)
    @photo.sort_position = Photo.last.sort_position + 1
    @photo.save!
    respond_to do |format|
      format.js
    end
  end

  def destroy
    photos = Photo.where('property_id = ? AND sort_position > ?', @photo.property_id, @photo.sort_position)
    photos.each { |photo| photo.update(sort_position: photo.sort_position - 1) }
    @photo.destroy!
  end

  def update
    new_index = params[:index].to_i
    old_index = @photo.sort_position

    if new_index > old_index
      photos = Photo.where('property_id = :property_id AND sort_position > :old_index AND sort_position <= :new_index', property_id: @photo.property_id, old_index: old_index, new_index: new_index)
      photos.each do |photo|
        new_position = photo.sort_position - 1
        photo.update(sort_position: new_position)
      end
    else
      photos = Photo.where('property_id = :property_id AND sort_position < :old_index AND sort_position >= :new_index', property_id: @photo.property_id, old_index: old_index, new_index: new_index)
      photos.each do |photo|
        new_position = photo.sort_position + 1
        photo.update(sort_position: new_position)
      end
    end
    @photo.update(sort_position: new_index)
  end

  private

  def photo_params
    params.require(:photo).permit(:file)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

end

