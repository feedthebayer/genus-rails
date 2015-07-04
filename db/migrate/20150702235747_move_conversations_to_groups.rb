class MoveConversationsToGroups < ActiveRecord::Migration
  def change
    change_table :conversations do |t|
      t.remove :conversational_type
      t.rename :conversational_id, :group_id
    end
  end
end
