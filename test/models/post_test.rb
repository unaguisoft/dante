require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test 'should not save post without title' do
    post = Post.new
    assert_not post.valid?
    assert_includes post.errors[:title], 'no puede estar en blanco'
  end

  test 'should not save post without subtitle' do
    post = Post.new
    assert_not post.valid?
    assert_includes post.errors[:subtitle], 'no puede estar en blanco'
  end

  test 'should not save post without body' do
    post = Post.new
    assert_not post.valid?
    assert_includes post.errors[:body], 'no puede estar en blanco'
  end

end
