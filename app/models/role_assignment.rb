class RoleAssignment < ActiveRecord::Base
  belongs_to :role
  belongs_to :user

  validates_presence_of :role

  scope :ordered_by_user, -> { includes(:user).order("users.name") }
  scope :ordered_by_role, -> { includes(:role).order("roles.name") }
end
