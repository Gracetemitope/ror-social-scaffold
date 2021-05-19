class AddInivite < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :inviter_id, :integer
    add_index :friendships, :inviter_id
    add_column :friendships, :invitee_id, :integer
    add_index :friendships, :invitee_id
  end
end
