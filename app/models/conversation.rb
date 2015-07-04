class Conversation < ActiveRecord::Base
  belongs_to :group, touch: true
  has_many :messages, dependent: :delete_all
  validates_presence_of :group
  acts_as_readable :on => :updated_at

  default_scope { order(updated_at: :desc) }

  def length
    self.messages.count
  end

  def organization
    self.group.organization
  end

  # def self.updated_on(date)
  #   where 'DATE(updated_at) = ?', date
  # end
end
