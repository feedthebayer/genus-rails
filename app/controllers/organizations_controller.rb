class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    @org = find_organization
    # TODO - only get today's messages
    @conversations = @org.conversations.includes(:messages).all
    @new_msg = Message.new
  end

  private

  def find_organization
    if current_organization.id == params[:id].to_i
      current_organization
    else
      Organization.includes(:conversations).find(params[:id])
    end
  end
end
