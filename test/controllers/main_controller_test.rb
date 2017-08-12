require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ross   = users(:ross)
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
    get properties_for_web_path, params: { property_filter: { description: @barbie.description, current_user: @ross } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by city' do
    get properties_for_web_path, params: { property_filter: { city_id: @barbie.city_id, current_user: @ross } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by property kind' do
    get properties_for_web_path, params: { property_filter: { property_kind: @barbie.property_kind, current_user: @ross } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by kind' do
    get properties_for_web_path, params: { property_filter: { kind: @barbie.kind, current_user: @ross } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by min price' do
    get properties_for_web_path, params: { property_filter: { price_from: @barbie.price, current_user: @ross } }
    assert_includes assigns(:properties), @barbie.decorate
    assert_not_includes assigns(:properties), @mickey.decorate
  end

  test 'should search by max price' do
    get properties_for_web_path, params: { property_filter: { price_to: @mickey.price, current_user: @ross } }
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

  test 'should get test map' do
    get test_map_path(address: '48 188 La Plata')
    assert_response :success
  end

  test 'should get posts' do
    get posts_for_web_path
    assert_equal Post.count, assigns(:posts).count

    assert_response :success
  end

  test 'should get a post' do
    a_post = posts(:one)
    get post_for_web_path(id: a_post.id)
    assert_equal a_post, assigns(:post)

    assert_response :success
  end

end
