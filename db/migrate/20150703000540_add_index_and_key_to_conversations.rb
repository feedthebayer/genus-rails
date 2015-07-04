class AddIndexAndKeyToConversations < ActiveRecord::Migration
  def change
    add_foreign_key :conversations, :groups
    add_index :conversations, :group_id
  end
end
