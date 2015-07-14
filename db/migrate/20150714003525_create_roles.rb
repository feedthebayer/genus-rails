class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.text :description
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :role_assignments do |t|
      t.belongs_to :role, index: true
      t.belongs_to :user, index: true
      t.string :note
      t.timestamps null: false
    end
  end
end
