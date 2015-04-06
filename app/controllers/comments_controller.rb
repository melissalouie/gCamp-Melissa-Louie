class CommentsController < ApplicationController

  def new
    @user = current_user
    @task = Task.find(params[:task_id])
    @project = Project.find(params[:project_id])
  end

  def create
    @user = current_user
    @task = Task.find(params[:task_id])
    @project = @task.project
    @comment = Comment.new(comment_params)
    @comment.user_id = @user.id
    @comment.task_id = params[:task_id]
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      return
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :task_id)
  end
end
