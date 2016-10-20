class PropertyFilter

  include ActiveModel::Model

  attr_accessor :id, :title, :kind, :city_id, :price_from, :price_to,
                :property_kind, :kind, :user_id, :description

  def call(context=nil)
    properties = (context.nil?) ? Property.all : context
    properties = properties.where(id: @id) if @id.present?
    properties = properties.where('title ILIKE ?', "%#{@title}%") if @title.present?
    properties = properties.where(property_kind: @property_kind) if @property_kind.present?
    properties = properties.where(kind: @kind) if @kind.present?
    properties = properties.where(city_id: @city_id) if @city_id.present?
    properties = properties.where(user_id: @user_id) if @user_id.present?
    properties = properties.where(price_in_cents: _price_from.._price_to) if @price_from.present? || @price_to.present?

    properties
  end

  private

  def _price_from
    (@price_from.to_d || 0).to_d * 10_000
  end

  def _price_to
    (@price_to || 50_000_000).to_d * 10_000
  end
end
