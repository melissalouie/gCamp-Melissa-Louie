require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested task" do
        user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: 'true')
        session[:user_id] = user.id
        project = Project.create(name: 'Test Project')
        task = Task.create(description: 'Test Task', due_date: '2015/04/20')
        put :update, project_id: project.id, id: task.id, :task => {id: task.id, description: 'Updated Task'}
        task.reload
        expect(task.description).to eq('Updated Task')
      end

      it "deletes the requested task" do
        user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: 'true')
        session[:user_id] = user.id
        project = Project.create(name: 'Test Project')
        task = Task.create(description: 'Test Task', due_date: '2015/04/20')
        tasks = Task.count
        delete :destroy, project_id: project.id, id: task.id
        expect(Task.count).to eq(tasks - 1)
      end

    end
  end
end
