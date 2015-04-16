require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  context "with valid params" do

    before(:each) do
      user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: 'true')
      session[:user_id] = user.id
      @project = Project.create(name: 'Test Project')
    end

    it "creates the requested project" do
      post :create, id: @project.id, :project => {id: @project.id, name: 'Test Project'}
      expect(@project.name).to eq('Test Project')
    end

    it "renders the show view" do
      get :show, id: @project.id
      expect(response).to render_template(:show)
    end

    it "updates the requested project" do
      put :update, id: @project.id, :project => {id: @project.id, name: 'Updated Project'}
      @project.reload
      expect(@project.name).to eq('Updated Project')
    end

    it "deletes the requested project" do
      projects = Project.count
      delete :destroy, id: @project.id
      expect(Project.count).to eq(projects - 1)
    end

  end

end
