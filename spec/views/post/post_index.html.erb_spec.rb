require 'rails_helper'

RSpec.describe 'post/post_index', type: :view do
  describe 'posts index page' do
    before(:each) do
      @user1 = User.create(name: 'Max', photo: 'verstappen.png', bio: 'Max Bio', posts_counter: 0,
                           email: 'maxverstappen@f1.com', password: 'redbull', confirmed_at: Time.now)

      @user2 = User.create(name: 'Lewis', photo: 'hamilton.png', bio: 'Lewis Bio', posts_counter: 0,
                           email: 'lewishamilton@f1.com', password: 'mercedes')

      visit root_path
      fill_in 'Email', with: 'maxverstappen@f1.com'
      fill_in 'Password', with: 'redbull'
      click_button 'Log in'

      @post1 = Post.create(title: 'Max Post', text: 'This is Max Post', comments_counter: 0, likes_counter: 0,
                           user: @user1)
      @post2 = Post.create(title: 'Lewis Post', text: 'This is Lewis Post', comments_counter: 0, likes_counter: 0,
                           user: @user1)
      @post3 = Post.create(title: 'Valtteri Post', text: 'This is Valtteri Post', comments_counter: 0,
                           likes_counter: 0, user: @user1)

      @comment1 = Comment.create(text: 'Hey Max', user: User.first, post: Post.first)
      @comment2 = Comment.create(text: 'Hey Again', user: User.first, post: Post.first)

      visit user_posts_path(@user1.id)
    end

    it 'displays user photo' do
      all('img').each do |img|
        expect(img[:src]).to eq('/assets/image-placeholder-
          7f9e46188c7130997159e7d14fe9f4eb1294685586712e2425e01be9fc6cf425.png')
      end
    end

    it 'displays user name' do
      expect(page).to have_content('Max')
    end

    it 'displays posts made by current user' do
      post = Post.all
      expect(post.size).to eq(3)
    end

    it 'displays user posts number' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it 'displays post title' do
      expect(page).to have_content('Max Post')
      visit user_session_path
    end

    it 'displays post content' do
      expect(page).to have_content('This is Max Post')
    end

    it 'display post comments' do
      expect(page).to have_content 'Hey Max'
    end

    it 'display comments counter.' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'displays likes counter' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it 'redirects to user show page when clicking on link' do
      click_link 'Max Post'
      expect(page).to have_current_path user_post_path(@post1.user_id, @post1)
    end
  end
end
