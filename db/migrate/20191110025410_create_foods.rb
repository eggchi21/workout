class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :protein
      t.integer :fat
      t.integer :carbo
      t.string  :unit
      t.integer :gram
      t.text :image_url
      t.timestamps
    end
  end
end
