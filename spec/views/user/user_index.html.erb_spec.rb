require 'rails_helper'

RSpec.describe 'user/index', type: :view do
  describe 'user index page' do
    before(:each) do
      @user1 = User.create(name: 'Max', photo: 'verstappen.png', bio: 'Max Bio', posts_counter: 0,
                           email: 'maxverstappen@f1.com', password: 'redbull', confirmed_at: Time.now)

      @user2 = User.create(name: 'Lewis', photo: 'hamilton.png', bio: 'Lewis Bio', posts_counter: 0,
                           email: 'lewishamilton@f1.com', password: 'mercedes')

      visit root_path
      fill_in 'Email', with: 'maxverstappen@f1.com'
      fill_in 'Password', with: 'redbull'
      click_button 'Log in'
    end

    it 'displays the current user' do
      expect(page).to have_content('Max')
    end

    it 'displays the user photo' do
      all('img').each do |img|
        expect(img[:src]).to eq('/assets/image-placeholder-
          7f9e46188c7130997159e7d14fe9f4eb1294685586712e2425e01be9fc6cf425.png')
      end
    end

    it 'displays the posts number' do
      all(:css, '.u-posts-counter').each do |post|
        expect(post).to have_content('Number of posts: ')
      end
    end

    it 'redirects to the user details page when clicking on user' do
      expect(page).to have_content('Number of posts: 0')
      click_on 'Max'
      expect(page).to have_no_content('Kevin')
    end
  end
end
