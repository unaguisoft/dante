class PropertyForWebPresenter

  attr_accessor :property

  def initialize(property_id)
    @property = Property.find(property_id).decorate
  end

  def highlighted_properties(limit=3)
    Property.highlighted.sample(limit)
  end

  def map_url
    address = @property.google_maps_address
    "https://www.google.com/maps/embed/v1/place?key=#{ENV['MAP_KEY']}&q=#{address}"
  end

end
