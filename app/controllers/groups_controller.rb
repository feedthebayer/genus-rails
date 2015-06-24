class GroupsController < ApplicationController
  before_action :require_login

  def create
    @org = find_organization
    @group = @org.groups.create(name: params[:group][:name])

    if @group.save
      redirect_to organization_groups_path(@org), change: "groups"
    else
      flash.now[:error] = "#{@group.errors.full_messages.first}"
      @groups = @org.groups.active
      @new_group = @group
      render :index, change: "new_group"
    end
  end

  def show
    if params[:date].present?
      @date = Time.zone.parse(params[:date]).to_date
    else
      @date = Time.zone.today
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
