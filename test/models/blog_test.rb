require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # transactionブロックで囲まなければ、ロールバックされる
  test 'without outer transaction' do
    blog = Blog.new(title: 'foo')
    refute blog.save
    assert_raise(ActiveRecord::RecordNotFound) do
      Blog.find_by! title: 'foo'
    end
  end

  # Commentは保存されないが、Blogだけが保存されてテストはfailする
  test 'invalid comment with outer transaction' do
    blog = Blog.new(title: 'foo')
    ApplicationRecord.transaction do
      refute blog.save
    end
    assert_raise(ActiveRecord::RecordNotFound) do
      Blog.find_by! title: 'foo'
    end
  end

  # save!なら例外が発生し、transactionブロックにそれが通知されるので、すべての処理がロールバックされる
  test 'invalid comment with outer transaction and save!' do
    blog = Blog.new(title: 'foo')
    assert_raise(ActiveRecord::RecordInvalid) do
      ApplicationRecord.transaction do
        refute blog.save!
      end
    end
    assert_raise(ActiveRecord::RecordNotFound) do
      Blog.find_by! title: 'foo'
    end
  end
end
