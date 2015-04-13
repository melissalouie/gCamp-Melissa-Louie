require 'rails_helper'

RSpec.describe ProjectsController do


  it "index" do
    Project.create(name: 'Test Project')
    get :index
    expect(page).to have_content('Test Project')
  end

  it "new" do
    get :new
    expect(page).to have_content('New Project')
  end

  it "show" do
    project = Project.create(name: 'Test Project')
    get :show, id: project.id
    expect(page).to have_content('Test Project')
  end

end
