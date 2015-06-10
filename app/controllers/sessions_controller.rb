class SessionsController < ApplicationController
  def new
    login_from_token if params[:token].present?
  end

  def create
    email = (params[:session][:email]).downcase
    if user = User.find_by(email: email)
      user.send_login_email
      flash[:success] = "The login link should be in your inbox in just a moment!"
      redirect_to :root
    else
      if email.blank?
        flash.now[:error] = "Email can't be blank"
      else
        flash.now[:error] =
          "Sorry, but I can't find #{email}. Are you sure that's correct?"
      end
      render :new
    end
  end

  def destroy
    log_out
    redirect_to :root
  end

  private

  def login_from_token
    user = User.find_by(id: params[:sid])
    password_token = params[:token]

    if user && user.password_digest && user.authenticate(password_token)
      flash[:success] = "Logged in! Remember to log out if on a public computer."
      log_in_and_remember user
      path = current_organization
    else
      flash[:error] = "Looks like that login link has expired.
        Please request a new one"
      path = request.path
    end

    redirect_to path, params.except(:sid, :token, :action, :controller)
  end
end
