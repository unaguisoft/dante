require 'test_helper'

class PropertyTest < ActiveSupport::TestCase

  test "should not save property without kind" do
    property = Property.new()
    property.kind = nil
    property.valid?
    assert_includes property.errors[:kind], 'no puede estar en blanco'
  end

  test "should not save property without property_kind" do
    property = Property.new()
    property.property_kind = nil
    property.valid?
    assert_includes property.errors[:property_kind], 'no puede estar en blanco'
  end

  test "should not save property without status" do
    property = Property.new()
    property.status = nil
    property.valid?
    assert_includes property.errors[:status], 'no puede estar en blanco'
  end

  test "should not save property without price" do
    property = Property.new()
    property.price = nil
    property.valid?
    assert_includes property.errors[:price], 'no puede estar en blanco'
  end

  test "should not save property without currency" do
    property = Property.new()
    property.currency = nil
    property.valid?
    assert_includes property.errors[:currency], 'no puede estar en blanco'
  end

  test "should not save property without built_area" do
    property = Property.new()
    property.built_area = nil
    property.valid?
    assert_includes property.errors[:built_area], 'no puede estar en blanco'
  end

  test "should not save property without semi_built_area" do
    property = Property.new()
    property.semi_built_area = nil
    property.valid?
    assert_includes property.errors[:semi_built_area], 'no puede estar en blanco'
  end

  test "should not save property without perimeter" do
    property = Property.new()
    property.perimeter = nil
    property.valid?
    assert_includes property.errors[:perimeter], 'no puede estar en blanco'
  end


  test "should not save property without address" do
    property = Property.new()
    property.address = nil
    property.valid?
    assert_includes property.errors[:address], 'no puede estar en blanco'
  end

  test "should not save property without number_of_bathrooms" do
    property = Property.new()
    property.number_of_bathrooms = nil
    property.valid?
    assert_includes property.errors[:number_of_bathrooms], 'no puede estar en blanco'
  end

  test "should not save property without number_of_bedrooms" do
    property = Property.new()
    property.number_of_bedrooms = nil
    property.valid?
    assert_includes property.errors[:number_of_bedrooms], 'no puede estar en blanco'
  end

  test "should not save property without city" do
    property = Property.new()
    property.city = nil
    property.valid?
    assert_includes property.errors[:city], 'no puede estar en blanco'
  end

  test "should not save property without owner" do
    property = Property.new()
    property.title = nil
    property.valid?
    assert_includes property.errors[:title], 'no puede estar en blanco'
  end

  test "should not save property without user" do
    property = Property.new()
    property.user = nil
    property.valid?
    assert_includes property.errors[:user], 'no puede estar en blanco'
  end

end
