class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def authorize
    # TODO - Check for correct user
    unless logged_in?
      flash[:error] = "You need to login first."
      redirect_to login_path
    end
  end
end
