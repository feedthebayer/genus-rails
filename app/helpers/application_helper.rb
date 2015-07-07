module ApplicationHelper
  def log_in_out_link_top
    if logged_in?
      link_to "Log Out", logout_path, method: :delete, class: "nav-logoutLink-top"
    else
      link_to "Log In", login_path, class: "nav-logoutLink-top"
    end
  end

  def log_in_out_link_bottom
    if logged_in?
      link_to "Log Out", logout_path, method: :delete, class: "nav-logoutLink-bottom"
    else
      link_to "Log In", login_path, class: "nav-logoutLink-bottom"
    end
  end
end
