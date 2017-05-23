require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest

  def setup
    sign_in_as(users(:ross))
    @photo = photos(:photo_one)
  end

  test "should update sort position" do
    # Cuando la nueva posición es mayor a la original
    new_position = 2
    photos = Photo.where('property_id = ? AND id != ? AND sort_position <= ? AND sort_position > ?', @photo.property_id, @photo.id, new_position, new_position).pluck(:id, :sort_position)
    put "/admin/photos/#{@photo.id}", params: { index: new_position }

    assert_response :success
    @photo.reload
    assert_equal new_position, @photo.sort_position
    photos.each do |photo|
      id, old_position = photo
      assert_equal old_position - 1, Photo.find(id).sort_position
    end

    # Cuando la nueva posición es menor a la original
    @photo = photos(:photo_three) 
    new_position = 0
    photos = Photo.where('property_id = ? AND id != ? AND sort_position >= ? AND sort_position < ?', @photo.property_id, @photo.id, new_position, new_position).pluck(:id, :sort_position)
    put "/admin/photos/#{@photo.id}", params: { index: new_position }

    assert_response :success
    @photo.reload
    assert_equal new_position, @photo.sort_position
    photos.each do |photo|
      id, old_position = photo
      assert_equal old_position + 1, Photo.find(id).sort_position
    end

  end

  test "should destroy photo and update sort position" do
    photos = Photo.where('property_id = ? AND sort_position > ?', @photo.property_id, @photo.sort_position).pluck(:id, :sort_position)
    
    assert_difference('Photo.count', -1) do
      delete "/admin/photos/#{@photo.id}", xhr: true
    end
    photos.each do |photo|
      id, old_position = photo
      assert_equal old_position - 1, Photo.find(id).sort_position
    end
  end
end
