class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  config.filter_parameters :password

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    unless current_user
      session[:return_to] = request.original_url
      redirect_to signin_path, :alert => 'You must be logged in to visit that page.'
    end
  end

  helper_method :current_user
  before_filter :check_token

  protected

  def check_token
    unless session[:token]
      session[:original_url] = request.url

    end
  end

end
