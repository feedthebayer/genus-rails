class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    @org = Organization.includes(:messages).find(params[:id])
    @messages = @org.messages # TODO - only get today's messages
    @new_message = Message.new(messageable: @org)
  end
end
