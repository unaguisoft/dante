require 'test_helper'

class OwnerTest < ActiveSupport::TestCase

  test "should not save owner without first_name" do
    owner = Owner.new()
    owner.first_name = nil
    owner.valid?
    assert_includes owner.errors[:first_name], 'no puede estar en blanco'
  end
  
  test "should not save owner without last_name" do
    owner = Owner.new()
    owner.last_name = nil
    owner.valid?
    assert_includes owner.errors[:last_name], 'no puede estar en blanco'
  end
  
  test "should not save owner without cellphone" do
    owner = Owner.new()
    owner.cellphone = nil
    owner.valid?
    assert_includes owner.errors[:cellphone], 'no puede estar en blanco'
  end
  
  test "should not save owner without email" do
    owner = Owner.new()
    owner.email = nil
    owner.valid?
    assert_includes owner.errors[:email], 'no puede estar en blanco'
  end
  
  test "should not save owner without agent (alias of user)" do
    owner = Owner.new()
    owner.agent = nil
    owner.valid?
    assert_includes owner.errors[:agent], 'no puede estar en blanco'
  end

end
