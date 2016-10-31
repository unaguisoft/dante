class CreateInvestmentPhoto < ActiveRecord::Migration[5.0]
  def change
    create_table :investment_photos do |t|
      t.string :file_uid
      t.string :file_name
      t.references :investment, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
