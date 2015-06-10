class RemoveRememberDigestFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :remember_digest, :string, null: false, default: '', index: true
  end
end
