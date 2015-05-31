class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversational, polymorphic: true
  has_many :messages
end
