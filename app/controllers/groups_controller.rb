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
    if params[:date].present?
      @date = Date.parse params[:date]
    else
      @date = Date.current
    end

    @org = find_organization
    @group = Group.includes(:conversations).find(params[:id])
    @conversations = @group.conversations.includes(:messages).updated_on @date
    @new_msg = Message.new
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
