class AddDefaultFieldToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :default, :boolean, default: false
  end
end
