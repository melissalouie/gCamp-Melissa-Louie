require 'rails_helper'

describe 'User can signup with valid credentials' do

  scenario 'User can signup valid credentials' do
    visit '/signup'
    User.create(email: 'john@example.com', first_name: 'John', last_name: 'Doe', password: 'password')
    fill_in 'user[first_name]', with: 'John'
    fill_in 'user[last_name]', with: 'Doe'
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    within('form') do
      click_on 'Sign Up'
    end
    expect(page).to have_content('You are now signed up.')
  end

  scenario 'User cannot signup without fulfilling validations' do
    visit '/signup'
    User.create(email: 'john@example.com', first_name: 'John', last_name: 'Doe', password: 'password')
    within('form') do
     click_on 'Sign Up'
    end
    expect(page).to have_content('errors')
  end
end
