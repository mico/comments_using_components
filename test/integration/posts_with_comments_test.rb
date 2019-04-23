require 'test_helper'

class PostsWithCommentsTest < ActionDispatch::IntegrationTest
  test 'should able to create comment for post' do
    post posts_url, params: { post: { text: 'test' } }
    assert_redirected_to post_url(Post.last)
    assert_difference('Comment.count') do
      post post_comments_url(Post.last), params: { comment: { text: 'test' } }
    end
    assert_redirected_to [Post.last, Comment.last]
  end
end
