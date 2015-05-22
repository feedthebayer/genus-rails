require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:brandon)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user, "current user not set"
    assert is_logged_in?, "not logged in"
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest("xxx"))
    assert_nil current_user
  end
end
