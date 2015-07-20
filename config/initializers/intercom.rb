IntercomRails.config do |config|
  config.app_id = ENV["INTERCOM_APP_ID"]
  config.api_secret = ENV["INTERCOM_API_SECRET"]

  # == Intercom API Key
  # This is required for some Intercom rake tasks like importing your users;
  # you can generate one at https://app.intercom.io/apps/api_keys.
  #
  config.api_key = ENV["INTERCOM_API_KEY"]

  # == Enabled Environments
  # Which environments is auto inclusion of the Javascript enabled for
  #
  config.enabled_environments = ["development", "production"]

  # == Include for logged out Users
  # If set to true, include the Intercom messenger on all pages, regardless of whether
  # The user model class (set below) is present. Only available for Apps on the Acquire plan.
  # config.include_for_logged_out_users = true

  # == Exclude users
  # A Proc that given a user returns true if the user should be excluded
  # from imports and Javascript inclusion, false otherwise.
  #
  # config.user.exclude_if = Proc.new { |user| user.deleted? }

  # == User Custom Data
  config.user.custom_data = {
    "messages" => Proc.new { |user| user.messages.count },
    "roles" => Proc.new { |user| user.roles.count }
  }

  # == User -> Company association
  # A Proc that given a user returns an array of companies
  # that the user belongs to.
  #
  # config.user.company_association = Proc.new { |user| user.companies.to_a }
  # config.user.company_association = Proc.new { |user| [user.company] }

  # == Current company method/variable
  config.company.current = Proc.new { current_organization }

  # == Company Custom Data
  config.company.custom_data = {
    "active groups" => Proc.new { |org| org.groups.count },
    "archived groups" => Proc.new { |org| org.groups.archived.count },
    "total conversations" => Proc.new { |org| org.conversations.count },
    "total messages" => Proc.new { |org| org.messages.count },
    "total roles" => Proc.new { |org| org.roles.count }
  }

  # == Company Plan name
  # This is the name of the plan a company is currently paying (or not paying) for.
  # e.g. Messaging, Free, Pro, etc.
  #
  # config.company.plan = Proc.new { |current_company| current_company.plan.name }

  # == Company Monthly Spend
  # This is the amount the company spends each month on your app. If your company
  # has a plan, it will set the 'total value' of that plan appropriately.
  #
  # config.company.monthly_spend = Proc.new { |current_company| current_company.plan.price }
  # config.company.monthly_spend = Proc.new { |current_company| (current_company.plan.price - current_company.subscription.discount) }

  # == Custom Style
  # By default, Intercom will add a button that opens the messenger to
  # the page. If you'd like to use your own link to open the messenger,
  # uncomment this line and clicks on any element with id 'Intercom' will
  # open the messenger.
  #
  # config.inbox.style = :custom
end
