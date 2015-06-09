class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :conversations, as: :conversational
  has_many :messages, through: :conversations
  validates_presence_of :name, :organization

  default_scope { order('name') }
end
