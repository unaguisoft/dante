class PropertyDecorator < Draper::Decorator
  delegate_all

  def identification
    "##{property.id}"
  end

  def address
    "#{property.address.capitalize}"
  end

  def complete_address
    "#{property.address.capitalize}, #{property.city.name.titleize}"
  end

  def built_area
    property.built_area ? "#{property.built_area} m2" : '-'
  end

  def semi_built_area
    property.semi_built_area ? "#{property.semi_built_area} m2" : '-'
  end

  def total_area
    property.total_area ? "#{property.total_area} m2" : '-'
  end

  def open_area
    property.total_area ? "#{property.total_area} m2" : '-'
  end

  def perimeter
    property.perimeter ? "#{property.perimeter} m" : '-'
  end

  def agent
    property.user
  end

  def first_photo_url(size='100x100')
    if photos.empty?
      "http://placehold.it/#{size}"
    else
      photos.first.file.thumb("#{size}#").url
    end
  end

  def public_price
    if property.should_display_price
      h.number_to_currency property.price, unit: currency()
    else
      "Consultar"
    end
  end

  def currency
    property.currency.upcase
  end

  private

  def property
    object
  end
end
