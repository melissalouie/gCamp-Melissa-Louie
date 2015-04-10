class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if session[:return_to]
       redirect_to session[:return_to], notice: 'You are now logged in.'
       session[:return_to] = nil
     else
       redirect_to projects_path, notice: 'You are now logged in.'
     end
    else
      flash.now[:alert] = "Username/password combination is invalid."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path, :notice => "Logged out"
  end
end
