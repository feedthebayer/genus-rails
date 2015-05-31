module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    user.clear_login_token!
  end

  def log_in_and_remember(user)
    log_in user
    remember user
  end

  def remember(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.new_remember_token!
  end

  def current_user
    return @current_user if @current_user ||= find_user(session[:user_id])

    # Try to login from cookie
    user = find_user(cookies.signed[:user_id])
    if user && user.remembered?(cookies[:remember_token])
      log_in user
      @current_user = user
    end
  end

  def find_user(id)
    User.includes(:organization).find_by(id: id)
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def current_organization
    if current_user
      @current_organization ||= @current_user.organization
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    if logged_in?
      forget current_user
      session.delete :user_id
      @current_user = nil
    end
  end

  # Forgets a persistent session.
  def forget(user)
    user.clear_remember_token!
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
