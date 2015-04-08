class MembershipsController < ApplicationController

  def index
    if is_member? || admin?
      @project = Project.find(params[:project_id])
      @memberships = @project.memberships
      @membership = Membership.new
    else
      flash[:alert] = "You do not have access to that project."
      redirect_to projects_path
    end
  end

  def new
    if is_member? || admin?
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
      flash[:notice] = "#{@membership.user.full_name} was successfully added."
    else
      render :index
    end
  end

  def update
    if owns_project? || admin?
      @project = Project.find(params[:project_id])
      @membership = Membership.find(params[:id])
      if @project.memberships.pluck(:role).select{ |role| role == false }.count > 1
        @membership.update(membership_params)
        redirect_to project_memberships_path(@project)
        flash[:notice] = "Membership successfully updated."
      else
        redirect_to project_memberships_path(@project), alert: "Projects must have at least one owner."
      end
    else
      redirect_to project_memberships_path(@project), alert: 'You do not have access to update.'
    end

  end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    if current_user.id == @membership.user_id || admin?
      @membership.destroy
      redirect_to projects_path
      flash[:notice] = "#{current_user.full_name} successfully removed"
    else
      flash[:alert] = "You do not have access to delete this membership."
    end
  end

  private

  def admin?
    current_user.admin == true
  end

  def owns_project?
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships
    @memberships.any?{ |membership| membership.user_id == current_user.id && membership.role == false }
  end

  def is_member?
    @project = Project.find(params[:project_id])
    current_user.memberships.pluck(:project_id).include?(@project.id)
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
