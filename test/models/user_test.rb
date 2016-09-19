require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(email: nil)
    user.valid?
    assert_includes user.errors[:email], 'no puede estar en blanco'
  end

  test "should not save user with repeated email" do
    user = User.new(email: users(:ross).email)
    user.valid?
    assert_includes user.errors[:email], 'ya está en uso'
  end

  test "should not save user without password" do
    user = User.new(email: 'admin@admin.com')
    user.password = nil
    user.valid?
    assert_includes user.errors[:password], 'no puede estar en blanco'
  end

  test "should not save user with short password" do
    user = User.new(email: 'admin@admin.com')
    user.password = '123'
    user.valid?
    assert_includes user.errors[:password], 'es demasiado corto (4 caracteres mínimo)'
  end
end
