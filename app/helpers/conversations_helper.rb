module ConversationsHelper

  def link_to_rest_of_conversation(conversation)
    return nil if conversation.length < 3

    number_of_messages = conversation.length - 2
    link_string =
      "View #{number_of_messages} more #{ "messsage".pluralize number_of_messages }"

    link_to link_string, [conversation.organization, conversation]
  end

  def empty_feed_notice
    content_tag(:p, "No conversations so far in this group. Start a new one or check a different group.", class: 'con-empty')
  end

  def link_for_mark_read(conversation)
    link_to 'Mark as read', organization_conversation_path(
      conversation.organization, conversation, read_status: 'read'),
      method: :patch, remote: true
  end
end
