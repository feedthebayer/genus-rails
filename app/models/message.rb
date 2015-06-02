class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation, touch: true
  validates_presence_of :body, :user, :conversation
end
