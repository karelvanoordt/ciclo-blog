class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_comments
    Comment.last(5)
  end

  def update_posts_counter
    user.increment!(:posts_counter)
  end
end
