require 'test_helper'

class ConversationTest < ActiveSupport::TestCase

  def setup
    @conversation = conversations(:one)
  end

  test "messages are deleted with a conversation" do
    assert @conversation.messages.count > 0, "no messages in conversation"
    @conversation.destroy!
    assert_equal 0, @conversation.messages.count, "message count != 0"
  end
end
