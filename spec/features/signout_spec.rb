require 'rails_helper'

describe 'User can signout' do
  scenario 'User can signout' do
    User.create(email: 'user@example.com', first_name: 'John', last_name: 'Doe', password: 'password')
    visit '/signin'
    fill_in 'email', with: 'user@example.com'
    fill_in 'password', with: 'password'
    within('form') do
      click_on 'Sign In'
    end
    click_on 'Sign Out'
    expect(page).to have_content('Logged out')
  end
end
