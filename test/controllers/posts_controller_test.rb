require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  test 'should not authorize non admin user' do
    sign_out
    sign_in_as users(:rachel)
    get posts_path
    assert_redirected_to login_path
  end

  class PostsTest < PostsControllerTest
    include AdminUserTestable

    test 'should get index' do
      get posts_path
      assert_response :success
      assert_not_nil assigns(:posts)
      assert_equal Post.count, assigns(:posts).send(:count)
    end

    test 'should get new' do
      get new_post_path
      assert_response :success
      assert_not_nil assigns(:post)
    end

    test 'should create post' do
      new_post_data = { title: 'New title', subtitle: 'New subtitle',
                         body: 'A super body' }
      assert_difference('Post.count') do
        post posts_path, params: { post: new_post_data }
      end
      assert_redirected_to posts_path

      new_post = Post.last
      assert new_post_data[:title], new_post.title
      assert new_post_data[:subtitle], new_post.subtitle
      assert new_post_data[:body], new_post.body
    end

    test 'should get edit post' do
      a_post = posts(:one)
      get edit_post_path(a_post), params: { id: a_post }
      assert_response :success
    end

    test "should update post" do
      a_post = posts(:one)
      new_data = { title: 'New title', subtitle: 'New subtitle',
                   body: 'A super body' }
      assert_record_differences(a_post, new_data) do
        put post_path(a_post), params: { id: a_post.id, post: new_data }
      end

      assert_redirected_to posts_path
    end

    test "should destroy post" do
      a_post = posts(:one)
      assert_difference('Post.count', -1) do
        delete post_path(a_post), params: { id: a_post }
      end

      assert_redirected_to posts_path
    end

  end

end
