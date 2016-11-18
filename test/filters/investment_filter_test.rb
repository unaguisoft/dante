require 'test_helper'

class InvestmentFilterTest < ActiveSupport::TestCase

  def setup
    @samsung = investments(:samsung_store)
    @apple   = investments(:apple_store)
  end


  test "should filter by id" do
    investments = InvestmentFilter.new(id: nil).call
    assert_includes investments, @samsung
    assert_includes investments, @apple
    
    investments = InvestmentFilter.new(id: @samsung.id).call
    assert_includes investments, @samsung
    assert_not_includes investments, @apple
    
    investments = InvestmentFilter.new(id: @apple.id).call
    assert_includes investments, @apple
    assert_not_includes investments, @samsung
  end

  test "should filter by title" do
    investments = InvestmentFilter.new(title: 'non_existent_title').call
    assert_empty investments
    
    investments = InvestmentFilter.new(title: @samsung.title).call
    assert_includes investments, @samsung
    assert_not_includes investments, @apple
  end
  
  test "should filter by address" do
    investments = InvestmentFilter.new(address: 'non_existent_address').call
    assert_empty investments

    investments = InvestmentFilter.new(address: @samsung.address).call
    assert_includes investments, @samsung
    assert_not_includes investments, @apple
  end

end
