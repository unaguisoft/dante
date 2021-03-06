require 'test_helper'

class PropertyFilterTest < ActiveSupport::TestCase

  def setup
    @ross           = users(:ross)
    @casa_de_barbie = properties(:casa_de_barbie)
    @casa_de_ken    = properties(:casa_de_ken)
    @casa_de_mickey = properties(:casa_de_mickey)
  end

  test "should not filter by user when any other filter is applied" do
    properties = PropertyFilter.new(id: @casa_de_ken.id, current_user: @ross).call
    assert_includes properties, @casa_de_ken

    properties = PropertyFilter.new(title: @casa_de_mickey.title, current_user: @ross).call
    assert_includes properties, @casa_de_mickey
  end

  test "should filter by id" do
    properties = PropertyFilter.new(id: nil, current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    
    properties = PropertyFilter.new(id: @casa_de_barbie.id, current_user: @ross).call
    assert_includes properties, @casa_de_barbie
  end

  test "should filter by title" do
    properties = PropertyFilter.new(title: 'non_existent_title', current_user: @ross).call
    assert_empty properties
    
    properties = PropertyFilter.new(title: 'Casa de Barbie', current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
  end
  
  test "should filter by property_kind" do
    properties = PropertyFilter.new(property_kind: nil, current_user: @ross).call
    assert_includes properties, @casa_de_barbie

    properties = PropertyFilter.new(property_kind: 3, current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(property_kind: 1, current_user: @ross).call
    assert_empty properties
  end
  
  test "should filter by kind" do
    properties = PropertyFilter.new(kind: nil, current_user: @ross).call
    assert_includes properties, @casa_de_barbie

    properties = PropertyFilter.new(kind: 0, current_user: @ross).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
    
    properties = PropertyFilter.new(kind: 1, current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(property_kind: 2, current_user: @ross).call
    assert_empty properties
  end

  test "should filter by status" do
    # Default status is 'active'
    properties = PropertyFilter.new(status: nil, current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_ken
    assert_includes properties, @casa_de_mickey

    @casa_de_ken.update(status: 1)
    properties = PropertyFilter.new(status: 0, current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    assert_includes properties, @casa_de_mickey

    properties = PropertyFilter.new(status: 1, current_user: @ross).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_mickey
  end

  
  test "should filter by city" do
    properties = PropertyFilter.new(city_id: nil, current_user: @ross).call
    assert_includes properties, @casa_de_barbie

    properties = PropertyFilter.new(city_id: cities(:la_plata), current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(city_id: cities(:tolosa), current_user: @ross).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
    
    properties = PropertyFilter.new(city_id: 0, current_user: @ross).call
    assert_empty properties
  end
  
  test "should filter by user" do
    properties = PropertyFilter.new(user_id: nil, current_user: @ross).call
    assert_includes properties, @casa_de_barbie

    properties = PropertyFilter.new(user_id: users(:ross), current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(user_id: users(:rachel), current_user: @ross).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
        
    properties = PropertyFilter.new(user_id: 0).call
    assert_empty properties
  end
  
  test "should filter by price" do
    properties = PropertyFilter.new(price_from: nil, price_to: nil, current_user: @ross).call
    assert_includes properties, @casa_de_barbie

    properties = PropertyFilter.new(price_from: @casa_de_barbie.price, price_to: @casa_de_barbie.price, current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    
    properties = PropertyFilter.new(price_from: @casa_de_ken.price, price_to: @casa_de_ken.price, current_user: @ross).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
        
    properties = PropertyFilter.new(price_from: 10_000_000, price_to: 10_000_000, current_user: @ross).call
    assert_empty properties
  end
  
  test "should not filter by current_user" do
    properties = PropertyFilter.new(current_user: @ross).call
    assert_includes properties, @casa_de_barbie
    assert_includes properties, @casa_de_mickey
    assert_includes properties, @casa_de_ken
  end

  test "should filter by number_of_bedrooms" do
    properties = PropertyFilter.new(number_of_bedrooms: 3).call
    assert_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_mickey

    properties = PropertyFilter.new(number_of_bedrooms: 2).call
    assert_includes properties, @casa_de_mickey
    assert_not_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken

    properties = PropertyFilter.new(number_of_bedrooms: 1).call
    assert_includes properties, @casa_de_barbie
    assert_not_includes properties, @casa_de_ken
    assert_not_includes properties, @casa_de_mickey
  end

end
