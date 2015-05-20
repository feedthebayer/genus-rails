class User < ActiveRecord::Base
  has_secure_password validations: false

  def new_token!
    SecureRandom.hex(16).tap do |random_token|
      update_attributes password: random_token
    end
  end
end
