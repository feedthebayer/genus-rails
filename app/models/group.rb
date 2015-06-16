class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :conversations, as: :conversational
  has_many :messages, through: :conversations
  validates_presence_of :name, :organization

  default_scope { order 'name' }
  scope :active, -> { where archived: false }
  scope :archived, -> { where archived: true }

  def archive!
    update_attributes archived: true
  end
end
