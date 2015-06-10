class MessagesController < ApplicationController
  before_action :require_login

  def create
    if params[:message][:body].blank?
      flash[:error] = "Messge body can't be blank"
      redirect_to :back
      return
    end

    @org = find_organization
    @conversation = find_or_create_conversation_in_parent
    @message = Message.new(user: current_user, conversation: @conversation,
                           body: params[:message][:body])

    if not @message.save
      flash[:error] = "#{@message.errors.full_messages.first}"
    end

    if new_conversation?
      flash[:success] = "Conversation created!"
      redirect_to :back, change: 'conversations'
    else
      redirect_to [@org, @message.conversation], change: 'messages'
    end
  end

  def update
    # redirect_to current_organization, change: "messages:#{@message.id}"
  end

  def destroy
    @org = find_organization
    @message = Message.find(params[:id])

    if not @message.destroy
      flash[:error] = "#{@message.errors.full_messages.first}"
    end

    if @message.conversation.messages.empty?
      @message.conversation.destroy!
      redirect_to @org
    else
      redirect_to [@org, @message.conversation], change: 'messages'
    end
  end

  private

  def find_organization
    if current_organization.id == params[:organization_id].to_i
      current_organization
    else
      Organization.find(params[:organization_id])
    end
  end

  def find_new_message_parent

  end

  def find_or_create_conversation_in_parent
    if new_conversation?
      create_conversation_in_parent
    else
      Conversation.find(params[:conversation_id])
    end
  end

  def new_conversation?
    params[:conversation_id].blank?
  end

  def create_conversation_in_parent
    if params[:group_id].present?
      parent = Group.find(params[:group_id])
    else
      parent = current_organization
    end
    parent.conversations.create!
  end
end
