class Organization < ActiveRecord::Base
  has_many :users
  has_many :messages, as: :messageable
  validates_presence_of :name
end
