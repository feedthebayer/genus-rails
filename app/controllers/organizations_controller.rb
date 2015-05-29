class OrganizationsController < ApplicationController
  def show
    @org = Organization.find(params[:id])
    @messages = @org.messages # TODO - only get today's messages
    @new_message = Message.new(messageable: @org)
  end
end
