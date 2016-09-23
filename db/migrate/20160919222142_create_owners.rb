class CreateOwners < ActiveRecord::Migration[5.0]
  def change
    create_table :owners do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phones
      t.string :cellphone, null: false
      t.string :email, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
