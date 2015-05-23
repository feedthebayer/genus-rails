class UserMailer < ApplicationMailer
  default from: "Genus <mail@genusapp.com>"

  def login(user)
    @user = user
    @login_url = login_url(sid: @user.id, token: @user.new_login_token!)
    mail to: @user.email, subject: "Login Link for Genus"
  end
end
