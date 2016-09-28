require 'test_helper'

class CityTest < ActiveSupport::TestCase
  test "should not save city without a name" do
    city = City.new()
    city.name = nil
    city.valid?
    assert_includes city.errors[:name], 'no puede estar en blanco'
  end
end
