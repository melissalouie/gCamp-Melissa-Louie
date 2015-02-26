require 'rails_helper'

describe 'User can signin with valid credentials' do
  scenario 'User can signin' do
    User.create(email: 'user@example.com', first_name: 'John', last_name: 'Doe', password: 'password')
    visit '/signin'
    fill_in 'email', with: 'user@example.com'
    fill_in 'password', with: 'password'
    within('form') do
      click_on 'Sign In'
    end
    expect(page).to have_content('John Doe')
  end

    scenario 'User cannot signin without fulfilling validations' do
      User.create(email: 'user@example.com', first_name: 'John', last_name: 'Doe', password: 'password')
      visit '/signin'
      fill_in 'password', with: 'password'
      within('form') do
        click_on 'Sign In'
      end
      expect(page).to have_content('Username/password combination is invalid.')
    end

end
