require 'test_helper'

class OwnerFilterTest < ActiveSupport::TestCase

  def setup
    @agent = users(:rachel)
    @admin = users(:ross)
    @joey     = owners(:joey)
    @monica   = owners(:monica)
    @chandler = owners(:chandler)
  end


  test "should filter by name" do
    owners = OwnerFilter.new(user: @admin, name: 'non_existent_first_name').call
    assert_empty owners
    
    owners = OwnerFilter.new(name: 'joey', user: @admin).call
    assert_includes owners, @joey
    assert_not_includes owners, @monica
    
    owners = OwnerFilter.new(name: 'geller', user: @admin).call
    assert_includes owners, @monica
    assert_not_includes owners, @joey
  end

  test "should filter by email" do
    owners = OwnerFilter.new(email: 'non_existent_email', user: @admin).call
    assert_empty owners
    
    owners = OwnerFilter.new(email: 'joey@friends.com', user: @admin).call
    assert_includes owners, @joey
    assert_not_includes owners, @monica
  end
  
  test "should filter by agent_id" do
    owners = OwnerFilter.new(agent_id: @agent.id, user: @agent).call
    assert_includes owners, @chandler
    assert_not_includes owners, @joey
    assert_not_includes owners, @monica
    
    owners = OwnerFilter.new(agent_id: @admin.id, user: @admin).call
    assert_includes owners, @joey
    assert_includes owners, @monica
    assert_not_includes owners, @chandler
  end

  test "an agent should only see his owners" do
    owners = OwnerFilter.new(user: @agent).call
    assert_includes owners, @chandler
    assert_not_includes owners, @joey
    assert_not_includes owners, @monica
  end

  test "an admin should see all the owners" do
    owners = OwnerFilter.new(user: @admin).call
    assert_includes owners, @joey
    assert_includes owners, @monica
    assert_includes owners, @chandler

    owners = OwnerFilter.new(user: @admin, agent_id: @agent.id).call
    assert_includes owners, @chandler
    assert_not_includes owners, @joey
    assert_not_includes owners, @monica
  end
end
