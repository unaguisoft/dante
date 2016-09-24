class PropertyFilter

  include ActiveModel::Model

  attr_accessor :id, :kind, :price_from, :price_to, :property_kind, :city_id,
                :user_id, :title

  def call
    properties = Property.all
    properties = properties.where(id: @id) if @id.present?
    properties = properties.where(property_kind: @property_kind) if @property_kind.present?
    properties = properties.where(kind: @kind) if @kind.present?
    properties = properties.where(city_id: @city_id) if @city_id.present?
    properties = properties.where(user_id: @user_id) if @user_id.present?
    properties = properties.where(price: _price_from.._price_to) if @price_from.present? || @price_to.present?

    properties
  end
  
  private
  
  def _price_from
    @price_from || 0
  end
  
  def _price_to
    @price_to || 10_000_000
  end
end
