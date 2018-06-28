class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :friender_id
      t.integer :friendee_id
      t.integer :status, default: 1
      t.timestamps
    end
    add_index :friendships, [:friender_id, :friendee_id]
  end
end

