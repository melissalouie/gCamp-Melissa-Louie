require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  context "with valid params" do

    before(:each) do
      @user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: true)
      session[:user_id] = @user.id
      @project = Project.create(name: 'Test Project')
      @task = Task.create(project_id: @project.id, description: 'Test Task', due_date: '2015/04/20')
      @comment = Comment.create(user_id: @user.id, task_id: @task.id, body: 'Test Comment')
    end

    it "creates the requested comment" do
      post :create, project_id: @project.id, task_id: @task.id, :comment => {id: @comment.id, body: 'Test Comment'}
      expect(@comment.body).to eq('Test Comment')
    end

  end

end
