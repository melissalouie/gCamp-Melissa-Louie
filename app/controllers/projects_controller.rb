class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      @projects = Project.all
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  def new
    if current_user
      @project = Project.new
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project successfully created."
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit
    if current_user
      @project = Project.find(params[:id])
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project successfully updated."
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def show
    if current_user
      @project = Project.find(params[:id])
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project successfully deleted."
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
