class User < ActiveRecord::Base
  belongs_to :organization
  has_many :messages
  has_many :role_assignments
  has_many :roles, through: :role_assignments
  has_secure_password validations: false
  acts_as_reader

  before_save :downcase_email
  validates_presence_of :name, :organization
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
            # TODO - send multiple login links to user in multiple orgs
            # uniqueness: { scope: :organization_id, case_sensitive: false }

  default_scope { order 'name' }

  def send_login_email
    UserMailer.login(self).deliver_later
  end

  def send_welcome_email_from(fromUser)
    UserMailer.welcome(self, fromUser).deliver_later
  end

  def send_new_account_email
    UserMailer.new_account(self).deliver_now
  end

  # Generates, encryptes, saves, & returns a new login token
  def new_login_token!
    SecureRandom.urlsafe_base64.tap do |random_token|
      update_attributes password: random_token
    end
  end

  def clear_login_token!
    update_attributes password: nil
  end

  # Generates, encryptes, saves, & returns a new remember token
  def new_remember_token!
    SecureRandom.urlsafe_base64.tap do |random_token|
      if remember_digests.length == 4
        remember_digests.pop
      end
      remember_digests.prepend User.digest(random_token)
      save!
      random_token
    end
  end

  def clear_remember_tokens!
    remember_digests.clear
    save!
  end

  def remembered?(remember_token)
    return false if remember_digests.empty?
    remember_digests.each do |digest|
      return true if BCrypt::Password.new(digest).is_password?(remember_token)
    end
    return false
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
