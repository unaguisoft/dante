class CreateInvestments < ActiveRecord::Migration[5.0]
  def change
    create_table :investments do |t|
      t.string :title, null: false
      t.text :details, null: false
      t.string :address, null: false
      t.boolean :should_display_on_web, default: false

      t.timestamps
    end
  end
end
