class PropertyFilter
  
  include ActiveModel::Model
  
  attr_accessor :id, :kind, :status, :price, :currency, :shoul_display_price, :expenses_cost,
        :property_status, :property_kind, :year, :number, :built_area, 
        :semi_built_area, :total_area, :perimeter, :has_parking, :address, 
        :description, :title, :number_of_rooms, :number_of_bedrooms,
        :number_of_bathrooms, :number_of_toilets, :should_display_on_web,
        :should_highlight_on_web, :city_id, :owner_id, :user_id
  
  def call
    properties = Property.all
    properties = properties.where(id: @id) if @id.present?
    
    properties
  end
end