class RoleAssignment < ActiveRecord::Base
  belongs_to :role
  belongs_to :user

  validates_presence_of :role
end
