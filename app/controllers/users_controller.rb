class UsersController < ApplicationController
  before_action :require_login

  def create
    @org = find_organization
    @user = @org.users.create(user_params)

    if @user.save
      @user.send_welcome_email_from(current_user)
      flash[:success] = "#{@user.name} (#{@user.email}) has been added and notified"
      redirect_to organization_users_path(@org)

      @intercom.events.create(
        :event_name => "Added a user",
        :email => current_user.email,
        :created_at => Time.now.to_i,
        :metadata => {
          "New user name" => @user.name,
          "New user email" => @user.email
        }
      )
    else
      flash.now[:error] = "#{@user.errors.full_messages.first(2).join(', ')}"
      @users = @org.users
      @new_user = @user
      render :index, change: "new_user"
    end
  end

  def show
    @org = find_organization
    @user = User.includes(:roles).find(params[:id])
  end

  def edit
    @org = find_organization
    @user = User.includes(:roles).find(params[:id])
  end

  def update
    @org = find_organization
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      @intercom.events.create(
        :event_name => "Updated their profile",
        :email => current_user.email,
        :created_at => Time.now.to_i,
        :metadata => {
          "Description?" => @user.description.present?
        }
      )
      redirect_to [@org, @user]
    else
      flash.now[:error] = "#{@user.errors.full_messages.first}"
      render :edit, change: :edit_user
    end
  end

  def index
    @org = find_organization
    @users = @org.users
    @new_user = User.new
  end

  def destroy
  end

  private

  def find_organization
    if current_organization.id == params[:organization_id].to_i
      current_organization
    else
      Organization.find(params[:organization_id])
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :description)
  end
end
