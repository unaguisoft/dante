class RequiredFieldsForProperties < ActiveRecord::Migration[5.0]
  def up
    change_column :properties, :built_area, :integer, limit: 8, null: true
    change_column :properties, :semi_built_area, :integer, limit: 8, null: true
    change_column :properties, :perimeter, :integer, limit: 8, null: true
  end

  def down
    change_column :properties, :built_area, :integer, limit: 8, null: false
    change_column :properties, :semi_built_area, :integer, limit: 8, null: false
    change_column :properties, :perimeter, :integer, limit: 8, null: false
  end
end
