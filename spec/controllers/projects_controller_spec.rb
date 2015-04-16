require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "PUT #update" do
    context "with valid params" do

      before(:each) do
        user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: 'true')
        session[:user_id] = user.id
      end

      it "creates the requested project" do
        project = Project.create(name: 'Test Project')
        post :create, id: project.id, :project => {id: project.id, name: 'Test Project'}
        expect(project.name).to eq('Test Project')
      end

      it "updates the requested project" do
        project = Project.create(name: 'Test Project')
        put :update, id: project.id, :project => {id: project.id, name: 'Updated Project'}
        project.reload
        expect(project.name).to eq('Updated Project')
      end

      it "deletes the requested project" do
        project = Project.create(name: 'Test Project')
        projects = Project.count
        delete :destroy, id: project.id
        expect(Project.count).to eq(projects - 1)
      end

      it "renders show view" do
        project = Project.create(name: 'Test Project')
        get :show, id: project.id
        expect(response).to render_template(:show)
      end
    end
  end

end
