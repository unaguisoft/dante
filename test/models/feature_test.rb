require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test "should not save feature without a name" do
    feature = Feature.new()
    feature.name = nil
    feature.valid?
    assert_includes feature.errors[:name], 'no puede estar en blanco'
  end
end
