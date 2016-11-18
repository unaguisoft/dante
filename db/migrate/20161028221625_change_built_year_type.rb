class ChangeBuiltYearType < ActiveRecord::Migration[5.0]
  def up
    change_column :properties, :year, :string
  end

  def down
    change_column :properties, :year, :integer, limit: 8
  end
end
