require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    before(:each) { get '/users/:user_id/posts' }

    it 'validates if action has correct response status' do
      expect(response).to have_http_status(:success)
    end

    it 'validates if action rendered a correct template' do
      expect(response).to render_template('index')
    end

    it 'validates if correct text is displayed' do
      expect(response.body).to include('Display All User X Posts')
    end
  end

  describe 'GET /show' do
    before(:each) { get '/users/:user_id/posts/show' }

    it 'validates if action has correct response status' do
      expect(response).to have_http_status(:success)
    end

    it 'validates if action rendered a correct template' do
      expect(response).to render_template('show')
    end

    it 'validates if correct text is displayed' do
      expect(response.body).to include('Display Post X information')
    end
  end
end
