class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :likes


  def recent_5_comments
    Comment.last(5)
  end

end
