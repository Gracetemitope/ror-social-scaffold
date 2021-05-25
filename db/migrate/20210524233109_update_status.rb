class UpdateStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_null :friendships, :confirmed, false
    change_column_default :friendships, :confirmed, from: nil, to: false
  end
end
