class GroupsController < ApplicationController
  before_action :require_login

  def create
    @org = find_organization
    @group = @org.groups.create(name: params[:group][:name])

    if @group.save
      redirect_to organization_groups_path(@org), change: "groups"

      @intercom.events.create(
        :event_name => "Created a group",
        :email => current_user.email,
        :created_at => Time.now.to_i,
      )
    else
      flash.now[:error] = "#{@group.errors.full_messages.first}"
      @groups = @org.groups.active
      @new_group = @group
      render :index, change: "new_group"
    end
  end

  def show
    @org = find_organization
    @group = Group.includes(:conversations).find(params[:id])
    if params[:page].present?
      @unread = false
      @conversations = @group.conversations.includes(:messages).read_by(current_user).page(params[:page])
    else
      @unread = true
      @conversations = @group.conversations.includes(:messages).unread_by(current_user)
    end
    @new_msg = Message.new
    render :show, change: 'messages'
  end

  def index
    @org = find_organization
    @groups = @org.groups.active
    @new_group = Group.new
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.archive!
      flash[:success] = "#{@group.name} has been archived"
    else
      flash[:error] = "#{@group.errors.full_messages.first}"
    end
    redirect_to @group.organization
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
