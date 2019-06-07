class Blog < ApplicationRecord
  has_many :comments

  after_create :add_initial_comment

  private

  def add_initial_comment
    comment = comments.new(content: 'Great!')
    comment.save!
  end
end
