class Blog < ApplicationRecord
  has_many :comments

  after_create :add_initial_comment

  private

  def add_initial_comment
    comment = comments.new
    # commentのバリデーションエラーで例外が発生する
    comment.save!
  end
end
