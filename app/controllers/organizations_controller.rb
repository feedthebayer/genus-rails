class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    @org = find_organization
    @conversations = @org.conversations.includes(:messages).page(params[:page])
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
