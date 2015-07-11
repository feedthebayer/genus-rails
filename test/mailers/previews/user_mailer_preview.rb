# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/login
  def login
    UserMailer.login(User.first)
  end

  def welcome
    UserMailer.welcome(User.first, User.second)
  end

  def new_account
    UserMailer.new_account(User.first)
  end

end
