class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    @org = find_organization
    @unread_count = @org.conversations.unread_by(current_user).count

    if params[:page].present? || @unread_count == 0
      @unread = false
      @conversations = @org.conversations.includes(:messages).read_by(current_user).page(params[:page])
    else
      @unread = true
      @conversations = @org.conversations.includes(:messages).unread_by(current_user)
    end
    @new_msg = Message.new
    render :show, change: 'messages'
  end

  private

  def find_organization
    if current_organization.id == params[:id].to_i
      current_organization
    else
      Organization.includes(:groups, :conversations).find(params[:id])
    end
  end
end
