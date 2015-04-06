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
    if current_user
      @project = Project.find(params[:project_id])
      @task = Task.find(params[:id])
      @user = current_user
      @comment = Comment.new
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    if current_user
      @project = Project.find(params[:project_id])
      @task = Task.find(params[:id])
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create

    @task = Task.new(task_params)
    @project = Project.find(params[:project_id])
    @task.project_id = params[:project_id]
    @task.completed = false

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @project = Project.find(params[:project_id])
    @task.project_id = params[:project_id]
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @project = Project.find(params[:project_id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :due_date, :completed)
    end
end
