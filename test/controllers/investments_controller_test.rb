require 'test_helper'

class InvestmentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @investment = investments(:samsung_store)
    sign_in_as(users(:ross))
    @investment_new_data = {
      title: 'Nueva inversión',
      details: 'lalalal',
      address: '47 nro 1231',
      should_display_on_web: true
    }
  end

  test 'should get index' do
    get investments_path
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Investment.all.count, assigns(:presenter).send(:investments).send(:count)
  end

  test "should filter investments by id" do
    get investments_path, params: { investment_filter: {id: @investment.id } }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:investments).send(:count)
    assert_includes assigns(:presenter).send(:investments), @investment.decorate
  end

  test "should filter investments by title" do
    get investments_path, params: { investment_filter: {title: @investment.title } }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:investments).send(:count)
    assert_includes assigns(:presenter).send(:investments), @investment.decorate
  end

  test "should filter investments by address" do
    get investments_path, params: { investment_filter: {address: @investment.address } }
    assert_response :success

    assert_includes assigns(:presenter).send(:investments), @investment.decorate
  end

  test "should get new investment" do
    get new_investment_path
    assert_not_nil assigns(:investment)
  end

  test "should create investment" do
    assert_difference('Investment.count', 1) do
      post investments_path, params: { investment: @investment_new_data }
    end

    investment = Investment.unscoped.last
    assert_redirected_to upload_investment_photos_investment_path(investment)

    investment.as_json.each do |key, value|
      assert_equal @investment_new_data[key.to_sym], value,
          "No guardó correctamente #{key}" if @investment_new_data.key?(key.to_sym)
    end
  end

  test 'should get edit investment' do
    get edit_investment_path(@investment), params: { id: @investment }
    assert_response :success
  end

  test "should update investment" do
    assert_record_differences(@investment, @investment_new_data) do
      put investment_path(@investment), params: { id: @investment.id, investment: @investment_new_data }
    end

    assert_redirected_to investments_path
  end

  test "should destroy investment" do
    assert_difference('Investment.count', -1) do
      delete investment_path(@investment), params: { id: @investment.id }
    end

    assert_redirected_to investments_path
  end
end
