class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation, touch: true
  validates_presence_of :body, :user, :conversation

  default_scope { order('created_at') }
end
