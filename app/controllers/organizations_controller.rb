class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    @org = find_organization
    @messages = @org.messages # TODO - only get today's messages
    @new_message = Message.new(messageable: @org)
  end

  private

  def find_organization
    if current_organization.id == params[:id].to_i
      current_organization
    else
      Organization.includes(:messages).find(params[:id])
    end
  end
end
