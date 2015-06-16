class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    if params[:date].present?
      @date = Date.parse params[:date]
    else
      @date = Date.today
    end

    @org = find_organization
    @conversations = @org.conversations.includes(:messages).updated_on @date
    @new_msg = Message.new
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
