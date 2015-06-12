ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs in a test user.
  def log_in_as(user)
    if integration_test?
      token = user.new_login_token!
      get login_path, sid: user.id, token: token
    else
      session[:user_id] = user.id
    end
  end

  private

  def integration_test?
    defined?(post_via_redirect)
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  def log_in_with_capybara_as(user)
    visit(login_path sid: user.id, token: user.new_login_token!)
  end

  def create_message(body)
    fill_in 'message_body', with: body
    click_button 'new-message'
  end

  def create_group(name)
    fill_in 'group_name', with: name
    click_button 'Create Group'
  end
end
