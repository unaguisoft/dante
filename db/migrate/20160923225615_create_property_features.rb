class CreatePropertyFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :property_features do |t|
      t.references :property, null: false, foreign_key: true, index: true
      t.references :feature, null: false, foreign_key: true, index: true
    end
  end
end
