class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def recent_5_comments
    Comment.last(5)
  end

  def update_posts_counter
    post.increment!(:posts_counter)
  end
end
