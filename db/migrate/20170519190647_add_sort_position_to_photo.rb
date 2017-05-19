class AddSortPositionToPhoto < ActiveRecord::Migration[5.0]
  def up
    add_column :photos, :sort_position, :integer

    update_sort_position_from_existing_photos()
  end
  
  def down
    remove_column :photos, :sort_position
  end

  def update_sort_position_from_existing_photos
    Property.reset_column_information
    Photo.reset_column_information
    properties = Property.joins(:photos).group('properties.id')
    properties.each do |property|
      index = 0
      photos = property.photos.order(created_at: :asc)
      photos.each do |photo|
        photo.update(sort_position: index)
        index += 1
      end
    end
  end

end
