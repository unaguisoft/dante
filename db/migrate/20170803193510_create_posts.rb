class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.string :image_uid
      t.string :image_name

      t.timestamps
    end
  end
end
