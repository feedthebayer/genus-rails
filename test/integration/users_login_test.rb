require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:brandon)
    @token = @user.new_login_token!
  end

  test "request login link with invalid email" do
    get login_path
    assert_template 'sessions/new', "wrong template"
    post login_path, session: { email: "" }
    assert_template 'sessions/new', "wrong error template"
    assert_not flash.empty?, "no flash msg"
    get root_path
    assert flash.empty?, "flash not cleared"
  end

  test "login with invalid link" do
    get login_path, sid: "xx", token: "xx"
    assert_redirected_to login_path, "not redirected"
    assert_not flash.empty?, "no flash msg"
    # get root_path
    # assert flash.empty?, "flash not cleared"
  end

  test "login with valid link then logout" do
    # Login
    get_via_redirect login_path, sid: @user.id, token: @token
    assert is_logged_in?, "not logged in"
    assert_equal '/', path, "sent to wrong page"
    assert_not flash.empty?, "no flash msg"
    assert_template 'static_pages/home', "wrong template"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path

    # Logout
    delete_via_redirect logout_path
    assert_not is_logged_in?, "not logged out"
    assert_equal '/', path, "sent to wrong page"
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", login_path
  end

  test "login link destroyed after use" do
    log_in_as @user
    assert_nil @user.reload.password_digest, "password token not deleted"
  end

  test "login creates cookie" do
    log_in_as @user
    assert_not_nil cookies['remember_token']
  end

  test "logout deletes cookie" do
    log_in_as @user
    delete logout_path
    assert_empty cookies['remember_token']
  end
end
