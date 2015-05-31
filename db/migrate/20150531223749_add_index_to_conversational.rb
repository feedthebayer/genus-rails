class AddIndexToConversational < ActiveRecord::Migration
  def change
    add_index :conversations, [:conversational_type, :conversational_id], name: "index_on_conversational"
  end
end
