class Organization < ActiveRecord::Base
  has_many :users
  has_many :groups
  has_many :conversations, through: :groups
  has_many :messages, through: :conversations
  has_many :roles, through: :groups
  validates_presence_of :name

  after_create :create_default_group

  private

  def create_default_group
    self.groups.create name: "Everyone", default: true
  end
end
