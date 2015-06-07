class Group < ActiveRecord::Base
  belongs_to :organization
  validates_presence_of :name, :organization
end
