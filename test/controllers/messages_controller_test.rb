require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  def setup
    log_in_as users(:brandon)
    @conversation = conversations(:one)
  end

  test "conversation is deleted when last message is" do
    assert @conversation.messages.count > 0, "no messages in conversation"
    @conversation.messages.all.each do |message|
      delete :destroy, organization_id: @conversation.conversational_id, id: message.id
    end
    assert_raises ActiveRecord::RecordNotFound do
      @conversation.reload
    end
  end
end
