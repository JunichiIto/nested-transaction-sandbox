class Blog < ApplicationRecord
  has_many :comments

  after_create :add_initial_comment

  private

  def add_initial_comment
    content = title == 'foo' ? '' : 'Great!'
    comment = comments.new(content: content)
    comment.save!
  end
end
