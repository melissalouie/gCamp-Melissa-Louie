class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships
    @membership = Membership.new
  end

  def new
    @project = Project.find(params[:project_id])
    @membership = Membership.new
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
  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
