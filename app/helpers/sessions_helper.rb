module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    user.update_attributes password: nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
