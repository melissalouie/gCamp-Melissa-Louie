class MembershipsController < ApplicationController

  def index
    if is_member?
      @project = Project.find(params[:project_id])
      @memberships = @project.memberships
      @membership = Membership.new
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  def new
    if is_member?
      @project = Project.find(params[:project_id])
      @membership = Membership.new
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  def create
    @membership = Membership.new(membership_params)
    @project = Project.find(params[:project_id])
    @membership.project_id = params[:project_id]
    if @membership.save
      redirect_to project_memberships_path(@project)
      flash[:notice] = "#{@membership.user.first_name} #{@membership.user.last_name} was successfully added."
    else
      render :index
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project)
      flash[:notice] = "Membership successfully updated."
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project)
    flash[:notice] = "Membership successfully deleted."
  end

  private

  def is_member?
    @project = Project.find(params[:project_id])
    current_user.memberships.pluck(:project_id).include?(@project.id)
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
