class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.integer :kind, limit: 1, null: false
      t.integer :status, limit: 1, null: false
      t.integer :price_in_cents, limit: 8, null: false
      t.integer :currency, limit: 1, null: false
      t.boolean :should_display_price, default: false
      t.integer :expenses_cost_in_cents, limit: 8
      t.integer :property_status, limit: 1, null: false
      t.integer :property_kind, limit: 2, null: false
      t.integer :year, limit: 4
      t.integer :number_of_floors, limit: 2
      t.integer :built_area, limit: 8, null: false
      t.integer :semi_built_area, limit: 8, null: false
      t.integer :total_area, limit: 8
      t.integer :perimeter, limit: 8, null: false
      t.boolean :has_parking, default: false, null: false
      t.string :address, null: false
      t.text :description
      t.string :title, null: false
      t.integer :number_of_rooms, limit: 2
      t.integer :number_of_bedrooms, limit: 2, null: false
      t.integer :number_of_bathrooms, limit: 2, null: false
      t.integer :number_of_toilets, limit: 2
      t.boolean :should_display_on_web, default: false, null: false
      t.boolean :should_highlight_on_web, default: false, null: false
      t.references :city, null: false, foreign_key: true, index: true
      t.references :owner, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
