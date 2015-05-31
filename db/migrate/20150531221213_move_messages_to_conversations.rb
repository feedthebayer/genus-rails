class MoveMessagesToConversations < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.remove :messageable_id
      t.remove :messageable_type
      t.references :conversation, index: true, foreign_key: true
    end
  end
end
