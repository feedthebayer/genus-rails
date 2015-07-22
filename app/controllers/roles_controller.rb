class RolesController < ApplicationController
  before_action :require_login

  def new
    @org = find_organization
    @group = Group.includes(:roles).find(params[:group_id])
    @role = Role.new
  end

  def create
    @org = find_organization
    @group = Group.find(params[:group_id])
    @role = @group.roles.create(role_params)

    if @role.save
      @intercom.events.create(
        :event_name => "Created a role",
        :email => current_user.email,
        :created_at => Time.now.to_i,
        :metadata => {
          "Role name" => @role.name,
          "Description?" => @role.description.present?,
          "Assigned users" => @role.users.count
        }
      )
      redirect_to [@org, @role]
    else
      flash.now[:error] = "#{@role.errors.full_messages.first}"
      render :new, change: :new_role
    end
  end

  def show
    @org = find_organization
    @role = Role.includes(:users).find(params[:id])
  end

  def edit
    @org = find_organization
    @role = Role.includes(:users).find(params[:id])
  end

  def update
    @org = find_organization
    @role = Role.find(params[:id])

    if @role.update_attributes(role_params)
      @intercom.events.create(
        :event_name => "Updated a role",
        :email => current_user.email,
        :created_at => Time.now.to_i,
        :metadata => {
          "Role name" => @role.name,
          "Description?" => @role.description.present?,
          "Assigned users" => @role.users.count
        }
      )
      redirect_to [@org, @role]
    else
      flash.now[:error] = "#{@role.errors.full_messages.first}"
      render :edit, change: :edit_role
    end
  end

  def destroy
    @org = find_organization
    @role = Role.find(params[:id])

    if @role.destroy
      flash[:success] = "The #{@role.name} role in #{@role.group.name} was deleted."
      @intercom.events.create(
        :event_name => "Deleted a role",
        :email => current_user.email,
        :created_at => Time.now.to_i,
        :metadata => {
          "Role name" => @role.name,
          "Description?" => @role.description.present?,
          "Assigned users" => @role.users.count
        }
      )
      redirect_to [@org, @role.group]
    else
      flash.now[:error] = "#{@role.errors.full_messages.first}"
      render :edit, change: :edit_role
    end
  end

  private

  def role_params
    params.require(:role).permit(:name, :description, { user_ids: [] })
  end

  def find_organization
    if current_organization.id == params[:organization_id].to_i
      current_organization
    else
      Organization.find(params[:organization_id])
    end
  end
end
