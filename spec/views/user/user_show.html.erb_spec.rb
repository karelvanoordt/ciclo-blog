require 'rails_helper'

RSpec.describe "user/show", type: :view do
  describe 'users show page' do
  
  before(:each) do
    @user_1 = User.create(name: 'Max', photo: 'verstappen.png', bio: 'Max Bio', posts_counter: 0, 
      email: 'maxverstappen@f1.com', password: 'redbull', confirmed_at: Time.now)

    @user_2 = User.create(name: 'Lewis', photo: 'hamilton.png', bio: 'Lewis Bio', posts_counter: 0, 
      email: 'lewishamilton@f1.com', password: 'mercedes')

    visit root_path  
    fill_in 'Email', with: 'maxverstappen@f1.com'
    fill_in 'Password', with: 'redbull'
    click_button 'Log in'

    @post_1 = Post.create(title: 'Max Post', text: 'This is Max Post', comments_counter: 0, likes_counter: 0, user: @user_1)
    @post_2 = Post.create(title: 'Lewis Post', text: 'This is Lewis Post', comments_counter: 0, likes_counter: 0, user: @user_1)
    @post_3 = Post.create(title: 'Valtteri Post', text: 'This is Valtteri Post', comments_counter: 0, likes_counter: 0, user: @user_1)

    visit user_path(@user_1.id)
  end

  it 'displays user profile photo' do
    all('img').each do |img|
      expect(img[:src]).to eq('/assets/image-placeholder-7f9e46188c7130997159e7d14fe9f4eb1294685586712e2425e01be9fc6cf425.png')
    end
  end

  it 'displays user name' do
    expect(page).to have_content('Max')
  end

  it 'displays users posts number' do
    user = User.first
    expect(page).to have_content(user.posts_counter)
  end

  it 'displays user first 3 posts' do
    expect(page).to have_content('Max')
    expect(page).to have_content('Lewis')
    expect(page).to have_content('Valtteri')
  end

  it 'display show all posts button' do
    expect(page).to have_button('See all posts')
  end

  it 'redirects to user posts when click all posts button' do
    click_link 'See all posts'
    expect(page).to have_content('Pagination')
  end
  
  end
end
