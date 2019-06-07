require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  test ".after_create" do
    blog = Blog.new(title: 'hello')
    assert blog.save
    assert blog.persisted?
    assert blog.comments.count == 1
  end

  test 'invalid comment' do
    blog = Blog.new(title: 'foo')
    refute blog.save
    refute blog.persisted?
    assert blog.comments.count == 0
  end
end
