class AddOpenAreaToProperty < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :open_area, :integer, limit: 8
  end
end
