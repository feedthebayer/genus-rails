class User < ActiveRecord::Base
  attr_accessor :remember_token
  belongs_to :organization
  has_secure_password validations: false

  before_save :downcase_email
  validates_presence_of :name
  validates_presence_of :organization
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def send_login_email
    UserMailer.login(self).deliver_later
  end

  # Generates, encryptes, saves, & returns a new login token
  def new_login_token!
    SecureRandom.urlsafe_base64.tap do |random_token|
      update_attributes password: random_token
    end
  end

  # Generates, encryptes, saves, & returns a new remember token
  def remember!
    SecureRandom.urlsafe_base64.tap do |random_token|
      self.remember_token = random_token
      update_attributes remember_digest: User.digest(random_token)
    end
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  # Returns hash digest of given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
