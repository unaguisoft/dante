require 'test_helper'

class PropertyFilterTest < ActiveSupport::TestCase

  def setup
    @casa_de_barbie = properties(:casa_de_barbie)
    @casa_de_ken    = properties(:casa_de_ken)
  end


  test "should filter by id" do
    properties = PropertyFilter.new(id: nil).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(id: @casa_de_barbie.id).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(id: @casa_de_ken.id).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
  end

  test "should filter by title" do
    properties = PropertyFilter.new(title: 'non_existent_title').call
    assert_empty properties
    
    properties = PropertyFilter.new(title: 'Casa de Barbie').call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
  end
  
  test "should filter by property_kind" do
    properties = PropertyFilter.new(property_kind: nil).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_ken

    properties = PropertyFilter.new(property_kind: 3).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(property_kind: 1).call
    assert_empty properties
  end
  
  test "should filter by kind" do
    properties = PropertyFilter.new(kind: nil).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_ken

    properties = PropertyFilter.new(kind: 0).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
    
    properties = PropertyFilter.new(kind: 1).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(property_kind: 2).call
    assert_empty properties
  end
  
  test "should filter by city" do
    properties = PropertyFilter.new(city_id: nil).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_ken

    properties = PropertyFilter.new(city_id: cities(:la_plata)).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(city_id: cities(:tolosa)).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
    
    properties = PropertyFilter.new(city_id: 0).call
    assert_empty properties
  end
  
  test "should filter by user" do
    properties = PropertyFilter.new(user_id: nil).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_ken

    properties = PropertyFilter.new(user_id: users(:ross)).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(user_id: users(:rachel)).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
        
    properties = PropertyFilter.new(user_id: 0).call
    assert_empty properties
  end
  
  test "should filter by price" do
    properties = PropertyFilter.new(price_from: nil, price_to: nil).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_ken

    properties = PropertyFilter.new(price_from: @casa_de_barbie.price, price_to: @casa_de_barbie.price).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(price_from: @casa_de_ken.price, price_to: @casa_de_ken.price).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
        
    properties = PropertyFilter.new(price_from: 10_000_000, price_to: 10_000_000).call
    assert_empty properties
  end
  
end
