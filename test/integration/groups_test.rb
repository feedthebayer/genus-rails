require 'test_helper'

class GroupsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:brandon)
    @org = @user.organization
    log_in_with_capybara_as @user
  end

  test "create new group, new conversation, & second message" do
    visit organization_groups_path @org
    create_group "Test Group 1"
    assert_equal organization_group_path(@org, @org.groups.first),
      current_path, "not at group path"
    create_message "Message from Capybara"
    assert_text "Message from Capybara"
    click_link "Reply"
    assert_equal organization_conversation_path(@org, @org.groups.first.conversations.first),
        current_path, "not at conversation path"
    assert_text "Message from Capybara"
    create_message "Second message from Capybara"
    assert_text "Second message from Capybara"
  end
end
