class ConversationsController < ApplicationController
  before_action :require_login

  def show
    @org = find_organization
    @conversation = Conversation.includes(:messages).find(params[:id])
    @messages = @conversation.messages.all
    @new_msg = @conversation.messages.build
  end

  private

  def find_organization
    if current_organization.id == params[:organization_id].to_i
      current_organization
    else
      Organization.find(params[:organization_id])
    end
  end
end
