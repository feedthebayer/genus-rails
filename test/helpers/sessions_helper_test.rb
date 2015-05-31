require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:brandon)
  end

  test "current_user & current_organization are set at login" do
    log_in_as @user
    remember @user
    assert_equal @user, current_user
    assert_equal @user.organization, current_organization
  end

  test "current_user returns user from cookie when session is nil" do
    remember @user
    assert_equal @user, current_user, "current user not set"
    assert is_logged_in?, "not logged in"
  end

  test "current_user returns nil when remember digest is wrong" do
    remember @user
    @user.update_attribute(:remember_digest, User.digest("xxx"))
    assert_nil current_user
  end
end
