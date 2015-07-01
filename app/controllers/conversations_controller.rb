class ConversationsController < ApplicationController
  before_action :require_login

  def show
    @org = find_organization
    # For some reason messages still get loaded in the view
    # @conversation = Conversation.includes(:messages).find(params[:id])
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_read! for: current_user
    @parent_path = get_parent_show_path_for @conversation
    @messages = @conversation.messages.all
    @new_msg = @conversation.messages.build
  end

  def update
    @org = find_organization
    @conversation = Conversation.find(params[:id])

    if params[:read_status] == 'read'
      @conversation.mark_as_read! for: current_user
    end

    redirect_to :back, change: 'messages'
  end

  private

  def find_organization
    if current_organization.id == params[:organization_id].to_i
      current_organization
    else
      Organization.find(params[:organization_id])
    end
  end

  def get_parent_show_path_for(conversation)
    if conversation.conversational_type == "Group"
      organization_group_path(conversation.organization, conversation.conversational)
    else
      organization_path(conversation.organization)
    end
  end
end
