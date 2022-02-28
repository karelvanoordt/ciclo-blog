class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post

  def update_comments_counter
    user.increment!(:comments_counter)
  end
end
