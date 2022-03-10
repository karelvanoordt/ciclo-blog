require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  background { visit new_user_session_path }
  scenario 'displays email field' do
    expect(page).to have_field('user[email]')
  end
end
