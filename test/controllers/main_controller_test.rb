require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @barbie = properties(:casa_de_barbie)
    @mickey = properties(:casa_de_mickey)
    @apple_store = investments(:apple_store)
    @samsung_store = investments(:samsung_store)
  end

  test 'should display home page' do
    get root_path
    assert_response :success
    assert_not_nil assigns(:presenter)
  end

  test 'should display highlighted properties' do
    get root_path
    assert_includes assigns(:presenter).highlighted_properties, @barbie
    assert_not_includes assigns(:presenter).highlighted_properties, @mickey
  end

  test 'should not display private properties' do
    non_public_property = properties(:casa_de_ken)
    get root_path
    assert_not_includes assigns(:presenter).highlighted_properties, non_public_property
  end

  test 'should display property details' do
    get property_details_path(id: @barbie.id)
    assert_response :success
  end

  test 'should search by description' do
    get properties_for_web_path, params: { property_filter: { description: @barbie.description } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by city' do
    get properties_for_web_path, params: { property_filter: { city_id: @barbie.city_id } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by property kind' do
    get properties_for_web_path, params: { property_filter: { property_kind: @barbie.property_kind } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by kind' do
    get properties_for_web_path, params: { property_filter: { kind: @barbie.kind } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by min price' do
    get properties_for_web_path, params: { property_filter: { price_from: @barbie.price } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by max price' do
    get properties_for_web_path, params: { property_filter: { price_to: @mickey.price } }
    assert_includes assigns(:properties), @mickey.decorate
    assert_not_includes assigns(:properties), @barbie.decorate
  end

  test 'should display investments' do
    get root_path
    assert_includes assigns(:presenter).investments, @apple_store
    assert_not_includes assigns(:presenter).investments, @samsung_store
  end

  test 'should display investment details' do
    get investment_details_path(id: @apple_store.id)
    assert_response :success
  end

end
