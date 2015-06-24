class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :setup_intercom
  include SessionsHelper

  private

  def setup_intercom
    @intercom = Intercom::Client.new(app_id: ENV["INTERCOM_APP_ID"],
                                     api_key: ENV["INTERCOM_API_KEY"])
  end
end
