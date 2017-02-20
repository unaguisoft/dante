class AddBankableToProperty < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :bankable, :boolean, default: false
  end
end
