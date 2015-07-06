class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :conversations
  has_many :messages, through: :conversations
  validates_presence_of :name, :organization
  # TODO - only allow one default group per organization

  # The default group should always be at the top of the list
  default_scope { active.order(default: :desc, name: :asc) }
  scope :active, -> { where archived: false }
  scope :archived, -> { where archived: true }

  def archive!
    update_attributes archived: true
  end
end
