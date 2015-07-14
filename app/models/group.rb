class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :conversations
  has_many :messages, through: :conversations
  has_many :roles

  validates_presence_of :name, :organization
  validate :organization_can_only_have_one_default_group

  # The default group should always be at the top of the list
  default_scope { active.order(default: :desc, name: :asc) }
  scope :active, -> { where archived: false }
  scope :archived, -> { where archived: true }

  def archive!
    if self.default != true
      update_attributes archived: true
    end
  end

  private

  def organization_can_only_have_one_default_group
    if self.default && self.organization.groups.find_by(default: true)
      errors.add :default, "Organization can only have 1 default group"
    end
  end
end
