require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'GET /index' do
    before(:each) { get users_path }

    it 'validates if action has correct response status' do
      expect(response).to have_http_status(:success)
    end

    it 'validates if action rendered a correct template' do
      expect(response).to render_template('index')
    end

    it 'validates if correct text is displayed' do
      expect(response.body).to include('Display All users')
    end
  end

  describe 'GET /index' do
    before(:each) { get users_path(10) }

    it 'validates if action has correct response status' do
      expect(response).to have_http_status(:success)
    end

    it 'validates if action rendered a correct template' do
      expect(response).to render_template('index')
    end

    it 'validates if correct text is displayed' do
      expect(response.body).to include('Display All users')
    end
  end
end
