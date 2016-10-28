class PropertyForWebPresenter

  attr_accessor :property

  def initialize(property_id)
    @property = Property.find(property_id).decorate
  end

  def highlighted_properties(limit=3)
    Property.highlighted.sample(limit)
  end
end
