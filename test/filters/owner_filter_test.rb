require 'test_helper'

class OwnerFilterTest < ActiveSupport::TestCase

  def setup
    @joey = owners(:joey)
    @monica = owners(:monica)
  end


  test "should filter by name" do
    owners = OwnerFilter.new(name: 'non_existent_first_name').call
    assert_empty owners
    
    owners = OwnerFilter.new(name: 'joey').call
    assert_includes owners, @joey
    assert_not_includes owners, @monica
    
    owners = OwnerFilter.new(name: 'geller').call
    assert_includes owners, @monica
    assert_not_includes owners, @joey
  end

  test "should filter by email" do
    owners = OwnerFilter.new(email: 'non_existent_email').call
    assert_empty owners
    
    owners = OwnerFilter.new(email: 'joey@friends.com').call
    assert_includes owners, @joey
    assert_not_includes owners, @monica
  end
  
  test "should filter by agent_id" do
    owners = OwnerFilter.new(agent_id: users(:rachel).id).call
    assert_empty owners
    
    owners = OwnerFilter.new(agent_id: users(:ross).id).call
    assert_includes owners, @joey
    assert_includes owners, @monica
  end
end
