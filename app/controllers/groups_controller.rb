class GroupsController < ApplicationController
  before_action :require_login

  def create
    @org = find_organization
    @group = @org.groups.create(name: params[:group][:name])

    if not @group.save
      flash[:error] = "#{@group.errors.full_messages.first}"
      redirect_to organization_groups_path(@org)
    else
      redirect_to [@org, @group]
    end
  end

  def show
    @org = find_organization
    @group = Group.includes(:conversations).find(params[:id])
    # TODO - only get today's messages
    @conversations = @group.conversations.includes(:messages).all
    @new_msg = Message.new
  end

  def index
    @org = find_organization
    @groups = @org.groups.all
    @new_group = Group.new
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
