require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @property = properties(:casa_de_barbie)
    sign_in_as(users(:ross))
    @property_new_data = {
        kind: 'comercial',
        price: 100000,
        currency: Property.currencies[:usd],
        should_display_price: true,
        expenses_cost_in_cents: 2000000,
        property_status: Property.statuses[:reservado],
        property_kind: Property.property_kinds[:local],
        year: 2005,
        number_of_floors: 2,
        built_area: 200,
        semi_built_area: 200,
        total_area: 400,
        perimeter: 350,
        has_parking: true,
        address: '12 Nro 1231',
        description: 'Esta es la descripción',
        title: 'Este es el título',
        number_of_rooms: 2,
        number_of_bedrooms: 2,
        number_of_bathrooms: 2,
        number_of_toilets: 2,
        should_display_on_web: true,
        should_highlight_on_web: true,
        city_id: cities(:tolosa).id,
        owner_id: owners(:monica).id
    }
  end

  test 'should get index' do
    get properties_path
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Property.all.count, assigns(:presenter).send(:properties).send(:count)
  end

  test "should filter properties by id" do
    get properties_path, params: { property_filter: {id: @property.id } }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:properties).send(:count)
    assert_includes assigns(:presenter).send(:properties), @property.decorate
  end

  test "should filter properties by city" do
    get properties_path, params: { property_filter: {city_id: @property.city_id } }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:properties).send(:count)
    assert_includes assigns(:presenter).send(:properties), @property.decorate
  end

  test "should filter properties by user" do
    get properties_path, params: { property_filter: {user_id: @property.user_id } }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:properties).send(:count)
    assert_includes assigns(:presenter).send(:properties), @property.decorate
  end

  test "should get new property" do
    get new_property_path
    assert_not_nil assigns(:property)
  end

  test "should create property" do
    # TODO Falta testear que agregue features
    assert_difference('Property.count', 1) do
      post properties_path, params: { property: @property_new_data }
    end
    assert_redirected_to properties_path

    property = Property.unscoped.last
    property.as_json.each do |key, value|
      assert_equal @property_new_data[key.to_sym], value,
          "No guardó correctamente #{key}" if @property_new_data.key?(key.to_sym)
    end
    assert_equal @property.user_id, users(:ross).id
  end

  test 'should get edit property' do
    get edit_property_path(@property), params: { id: @property }
    assert_response :success
  end

  test "should update property" do
    assert_record_differences(@property, @property_new_data) do
      put property_path(@property), params: { id: @property.id, property: @property_new_data }
    end

    assert_redirected_to properties_path
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete property_path(@property), params: { id: @property.id }
    end

    assert_redirected_to properties_path
  end
end
