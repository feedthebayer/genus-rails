class Role < ActiveRecord::Base
  belongs_to :group, touch: true
  has_many :role_assignments
  has_many :users, through: :role_assignments

  validates_presence_of :name, :group

  default_scope { order name: :asc }
end
