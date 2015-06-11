require 'test_helper'

class ConversationsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:brandon)
    @org = @user.organization
    log_in_with_capybara_as @user
  end

  def create_message(message_body)
    fill_in 'message_body', with: message_body
    click_button 'new-message'
  end

  test "create new message & conversation from org page" do
    visit organization_path @org
    assert_equal organization_path(@org), current_path, "not at org path"
    create_message "Message from Capybara"
    assert_text "Message from Capybara"
  end

  test "create new message on conversation page" do
    visit organization_path @org
    create_message "Message from Capybara"
    click_link "Reply"
    assert_equal organization_conversation_path(@org, @org.conversations.first),
        current_path, "not at conversation path"
    assert_text "Message from Capybara"
    create_message "Second message from Capybara"
    assert_text "Second message from Capybara"
  end

  test "number of more messages link on org page" do
    visit organization_path @org
    create_message "Message from Capybara"
    assert_no_selector '.msg-separator'
    click_link "Reply"
    create_message "Message 2 from Capybara"
    visit organization_path @org
    assert_no_selector '.msg-separator'
    click_link "Reply"
    create_message "Message 3 from Capybara"
    visit organization_path @org
    within '.msg-separator' do
      click_link "1"
    end
    create_message "Message 4 from Capybara"
    visit organization_path @org
    within '.msg-separator' do
      click_link "2"
    end
  end
end
