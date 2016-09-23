class PropertyDecorator < Draper::Decorator
  delegate_all

  def identification
    "##{property.id}"
  end
  
  def address
    "#{property.address.capitalize}"
  end
  
  def built_area
    "#{property.built_area} m2"
  end
  
  def total_area
    "#{property.total_area} m2"
  end
  
  def agent
    property.user.email
  end

  private
  
  def property
    object
  end
end
