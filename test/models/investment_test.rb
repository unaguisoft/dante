require 'test_helper'

class InvestmentTest < ActiveSupport::TestCase
  
  test "should not save investment without title" do
    investment = Investment.new()
    investment.title = nil
    investment.valid?
    assert_includes investment.errors[:title], 'no puede estar en blanco'
  end
  
  test "should not save investment without details" do
    investment = Investment.new()
    investment.details = nil
    investment.valid?
    assert_includes investment.errors[:details], 'no puede estar en blanco'
  end
  
  test "should not save investment without address" do
    investment = Investment.new()
    investment.address = nil
    investment.valid?
    assert_includes investment.errors[:address], 'no puede estar en blanco'
  end
  
end
