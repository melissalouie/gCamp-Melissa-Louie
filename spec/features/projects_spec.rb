require 'rails_helper'

describe 'Users can CRUD projects' do
  before :each do
    User.create(first_name: 'Missy', last_name: 'Louie', email: 'missy@mail.com', password: 'password', admin: true)
    visit '/signin'
    fill_in 'email', with: 'missy@mail.com'
    fill_in 'password', with: 'password'
    within('form') do
      click_on 'Sign In'
    end
    visit '/projects'
    within('.page-header') do
      click_on 'New Project'
    end
    fill_in 'project_name', with: 'First Project'
    click_on 'Create Project'
  end

  scenario 'User can create project' do
    expect(page).to have_content('First Project')
  end

  scenario 'User can edit a project' do
    visit '/projects'
    within('table') do
      click_on 'First Project'
    end
    click_on 'Edit'
    fill_in 'project[name]', with: 'Edited Project'
    click_on 'Update Project'
    expect(page).to have_content('Edited Project')
  end

  scenario 'User can delete a project' do
    visit '/projects'
    within('table') do
      click_on 'First Project'
    end
    click_on 'Delete'
    expect(page).to have_no_content('First Project')
  end
end
