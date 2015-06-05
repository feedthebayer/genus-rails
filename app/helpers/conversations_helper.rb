module ConversationsHelper

  def link_to_rest_of_conversation(conversation)
    return nil if conversation.length < 3

    link_to "#{conversation.length - 2} more messages",
    [conversation.conversational, conversation]
  end
end
