class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :conversational, polymorphic: true

      t.timestamps null: false
    end
  end
end
