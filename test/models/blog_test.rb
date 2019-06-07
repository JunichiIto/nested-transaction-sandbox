require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  test ".after_create" do
    blog = Blog.new(title: 'hello')
    blog.save
    assert blog.persisted?
    assert blog.comments.count == 1
  end
end
