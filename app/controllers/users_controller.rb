class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:create]


  def index
    if current_user
      @users = User.all
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  def show
  end

  def new
    if current_user
      @user = User.new
    else
      redirect_to root_path, notice: "You must be logged in to view this page."
    end
  end

  def edit
    if current_user.id == @user.id || admin?
      @user = User.find(params[:id])
    else
      render file: 'public/404', :status => 404
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to new_project_path, notice: 'You are now signed up.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
     if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if current_user.id == @user.id || admin?
      @user.comments.each do |comment|
        comment.update(user_id: nil)
      end
      session[:user_id] = nil
      @user.destroy
      redirect_to root_path
      flash[:notice] = "User was successfully deleted."
    else
      @user.comments.each do |comment|
        comment.update(user_id: nil)
      end
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def admin?
      if current_user
        current_user.admin == true
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
