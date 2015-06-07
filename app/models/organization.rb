class Organization < ActiveRecord::Base
  has_many :users
  has_many :groups
  has_many :conversations, as: :conversational
  has_many :messages, through: :conversations
  validates_presence_of :name
end
