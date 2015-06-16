module ConversationsHelper

  def link_to_rest_of_conversation(conversation)
    return nil if conversation.length < 3

    number_of_messages = conversation.length - 2
    link_string =
      "#{number_of_messages} more #{ "messsage".pluralize number_of_messages }"

    link_to link_string, [conversation.organization, conversation]
  end

  def empty_feed_notice
    content_tag(:p, "Go to another day or check on a different group", class: 'con-empty')
  end
end
