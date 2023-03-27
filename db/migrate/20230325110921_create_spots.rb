class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.float :price, null: false
      t.longtext :image_url
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
