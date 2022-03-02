require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post model tests' do
    user = User.create(name: 'Danka', bio: 'Danka bio')
    subject do
      Post.new(title: 'Danka Post', text: 'This is Danka Post', user_id: user)
    end
    before { subject.save }

    it 'validates if post title is not blank' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'validates if the title has less than 250 characters' do
      subject.title = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec qu'
      expect(subject).to_not be_valid
    end

    it 'validates if likes counter is greater or equal than zero - right case' do
      subject.likes_counter = 2
      expect(subject).to_not be_valid
    end

    it 'validates if likes counter is greater or equal than zero - wrong case' do
      subject.likes_counter = -2
      expect(subject).to_not be_valid
    end

    it 'validates the 5 recent comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end

  end
end
