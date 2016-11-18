class ChangePerimeterType < ActiveRecord::Migration[5.0]
  def up
    change_column :properties, :perimeter, :string
  end

  def down
    change_column :properties, :perimeter, :integer, limit: 8
  end
end
