class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :conversations, as: :conversational
  has_many :messages, through: :conversations
  validates_presence_of :name, :organization

  default_scope { alphabetical }
  scope :active, -> { alphabetical.where archived: false }
  scope :archived, -> { alphabetical.where archived: true }
  scope :alphabetical, -> { order 'name' }

  def archive!
    update_attributes archived: true
  end
end
