require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested project" do
        user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: 'true')
        session[:user_id] = user.id
        project = Project.create(name: 'Test Project')
        put :update, id: project.id, :project => {id: project.id, name: 'Updated Project'}
        project.reload
        expect(project.name).to eq('Updated Project')
      end

      it "deletes the requested project" do
        user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: 'true')
        session[:user_id] = user.id
        project = Project.create(name: 'Project')
        projects = Project.count
        delete :destroy, id: project.id
        expect(Project.count).to eq(projects - 1)
      end
    end
  end

end
