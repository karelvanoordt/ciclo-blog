require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User model tests' do
    subject { User.new(name: 'Rex', photo: 'Rex.png', bio: 'Rex bio', posts_counter: 0) }
    before { subject.save }

    it 'validates if name is not blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'validates if posts_counter is an integer' do
      subject.posts_counter = 'x'
      expect(subject).to_not be_valid
    end

    it 'validates if posts_counter is greater than or equal to zero' do
      expect(subject.posts_counter).to be >= 0
    end
  end

  describe 'validate recent_posts method' do
    before do
      4.times do |post|
        Post.create(user_id: subject, title: "This is a test post #{post}", text: 'This is a test text for test post')
      end
    end

    it 'validates three recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.last(3))
    end
  end
end
