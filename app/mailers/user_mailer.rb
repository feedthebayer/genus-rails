class UserMailer < ApplicationMailer
  default from: "Genus Staff <support@genusapp.com>"

  def login(user)
    @user = user
    @login_url = login_url_for @user
    mail to: @user.email, subject: "Login Link for Genus"
  end

  def welcome(user, fromUser)
    @user = user
    @fromUser = fromUser
    @login_url = login_url_for @user
    mail to: @user.email, subject: "#{@fromUser.name} Added You To #{@user.organization.name}'s Genus Account"
  end

  def new_account(user)
    @user = user
    @login_url = login_url_for @user
    mail to: @user.email, subject: "Welcome to #{@user.organization.name}'s Genus Account"
  end

  private

  def login_url_for(user)
    login_url(sid: @user.id, token: @user.new_login_token!)
  end
end
