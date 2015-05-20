class SessionsController < ApplicationController
  def new
    maybe_signin_from_token
  end

  def create
    email = params[:session][:email].downcase
    if user = User.find_by(email: email)
      #email link
    else
      flash[:error] =
        "Sorry, but I can't find #{email}. Are you sure that's correct?"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to :root
  end

  private

  def maybe_signin_from_token
    return if params[:token].blank?

    user = User.find_by(id: params[:sid])
    password = params[:token]

    if user && user.password_digest && user.authenticate(password)
      flash[:success] = "Signed in!"
      sign_in user
      path = :root # TODO - redirect to organization
    else
      flash[:error] = "Looks like that sign-in link has expired.
        Please request a new one"
      path = request.path
    end

    redirect_to path, params.except(:sid, :token, :action, :controller)
  end
end
