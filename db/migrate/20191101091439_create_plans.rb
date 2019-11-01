class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.decimal :start_weight, precision: 4, scale: 1
      t.decimal :target_weight, precision: 4, scale: 1
      t.date :start_on
      t.date :target_on
      t.integer :method
      t.integer :protein
      t.integer :fat
      t.integer :carbo
      t.references :user
      t.timestamps
    end
  end
end
