class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def incomplete
    if current_user
      @tasks = Task.all
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end
  # GET /tasks
  # GET /tasks.json
  def index
    if current_user
      @project = Project.find(params[:project_id])
      @tasks = @project.tasks
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    if is_member? || admin?
      @project = Project.find(params[:project_id])
      @task = Task.find(params[:id])
      @user = current_user
      @comment = Comment.new
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  # GET /tasks/new
  def new
    if is_member? || admin?
      @project = Project.find(params[:project_id])
      @task = Task.new
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  # GET /tasks/1/edit
  def edit
    if is_member? || admin?
      @project = Project.find(params[:project_id])
      @task = Task.find(params[:id])
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @project = Project.find(params[:project_id])
    @task.project_id = params[:project_id]
    @task.completed = false
    if @task.save
        redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
      else
        render :new
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if is_member? || admin?
      @project = Project.find(params[:project_id])
      @task.project_id = params[:project_id]
      if @task.update(task_params)
        redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
      else
        render :edit
      end
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    if is_member? || admin?
      @project = Project.find(params[:project_id])
      @task.destroy
      redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  private

    def admin?
      current_user.admin == true
    end

    def is_member?
      @project = Project.find(params[:project_id])
      current_user.memberships.pluck(:project_id).include?(@project.id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :due_date, :completed)
    end
end
