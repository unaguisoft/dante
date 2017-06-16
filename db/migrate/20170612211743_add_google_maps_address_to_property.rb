class AddGoogleMapsAddressToProperty < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :google_maps_address, :string
  end
end
