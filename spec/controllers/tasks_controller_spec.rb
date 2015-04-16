require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  context "with valid params" do

    before(:each) do
      user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: 'true')
      session[:user_id] = user.id
      @project = Project.create(name: 'Test Project')
      @task = Task.create(description: 'Test Task', project_id: @project.id, due_date: '2015/04/20')
    end

    it "creates the requested task" do
      post :create, project_id: @project.id, :task => {id: @task.id, description: 'Test Task'}
      expect(@task.description).to eq('Test Task')
    end

    it "renders the show view" do
      get :show, project_id: @project.id, id: @task.id
      expect(response).to render_template(:show)
    end

    it "updates the requested task" do
      put :update, project_id: @project.id, id: @task.id, :task => {id: @task.id, description: 'Updated Task'}
      @task.reload
      expect(@task.description).to eq('Updated Task')
    end

    it "deletes the requested task" do
      tasks = Task.count
      delete :destroy, project_id: @project.id, id: @task.id
      expect(Task.count).to eq(tasks - 1)
    end

  end

end
