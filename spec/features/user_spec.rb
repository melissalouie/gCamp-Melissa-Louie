require 'rails_helper'

describe 'User can CRUD Users' do
  before :each do
    visit '/'
    click_on "Users"
    click_on "New User"
    fill_in 'user[first_name]', with: 'Melissa'
    fill_in 'user[last_name]', with: 'Louie'
    fill_in 'user[email]', with: 'melissa@mail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Create User'
  end

  scenario 'User can create a user' do
    expect(page).to have_content('Melissa Louie')
  end

  scenario 'User can edit a user' do
    click_on 'Edit'
    fill_in 'user[first_name]', with: 'Missy'
    click_on 'Update User'
    expect(page).to have_content('Missy Louie')
  end

  scenario 'User can delete a user' do
    click_on 'Delete'
    expect(page).to have_no_content('Melissa Louie')

  end

end
