require 'rails_helper'

describe 'Users can CRUD projects' do
  before :each do
    User.create(first_name: 'Missy', last_name: 'Louie', email: 'missy@mail.com', password: 'password')
    visit '/signin'
    fill_in 'email', with: 'missy@mail.com'
    fill_in 'password', with: 'password'
    within('form') do
      click_on 'Sign In'
    end
    visit '/projects'
    click_on 'Create Project'
    fill_in 'project_name', with: 'First Project'
    click_on 'Create Project'
  end

  scenario 'User can create project' do
    expect(page).to have_content('First Project')
  end

  scenario 'User can edit a project' do
    click_on 'Edit'
    fill_in 'project[name]', with: 'Second Project'
    click_on 'Update Project'
    expect(page).to have_content('Second Project')
  end

  scenario 'User can delete a project' do
    click_on 'Delete'
    expect(page).to have_no_content('First Project')
  end
end
