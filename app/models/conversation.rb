class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversational, polymorphic: true, touch: true
  has_many :messages, dependent: :destroy

  default_scope { order('updated_at') }

  def length
    self.messages.count
  end
end
