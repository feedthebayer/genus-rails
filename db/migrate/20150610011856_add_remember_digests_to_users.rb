class AddRememberDigestsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_digests, :text, array:true, default: []
  end
end
