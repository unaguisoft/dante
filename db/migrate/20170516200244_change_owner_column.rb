class ChangeOwnerColumn < ActiveRecord::Migration[5.0]
  def change
    change_column_null :owners, :user_id, true
  end
end
