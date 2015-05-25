module ApplicationHelper
  def log_in_out_link
    if logged_in?
      link_to "Log Out", logout_path, method: :delete
    else
      link_to "Log In", login_path
    end
  end
end
