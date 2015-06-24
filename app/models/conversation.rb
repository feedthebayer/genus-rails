class Conversation < ActiveRecord::Base
  belongs_to :conversational, polymorphic: true, touch: true
  has_many :messages, dependent: :delete_all
  validates_presence_of :conversational

  default_scope { order('updated_at') }
  scope :today, lambda { where('DATE(updated_at) = ?', Time.zone.today) }

  def length
    self.messages.count
  end

  def organization
    if conversational_type == "Organization"
      self.conversational
    elsif conversational_type == "Group"
      self.conversational.organization
    end
  end

  def self.updated_on(date)
    where 'DATE(updated_at) = ?', date
  end
end
