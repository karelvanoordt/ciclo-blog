require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment model tests' do
    subject { Comment.new(text: 'Text test', user_id: 1, post_id: 1) }

    before { subject.save }

    it 'validates if update_comments_counter increases count' do
      before_counter = Post.find(1).comments_counter
      subject.update_comments_counter
      expect(Post.find(1).comments_counter).to eq(before_counter + 1)
    end
  end
end
