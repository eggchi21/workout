class ChangeDatatypeFatOfFoods < ActiveRecord::Migration[5.2]
  def change
    change_column :foods, :protein, :decimal, precision: 10, scale: 2
    change_column :foods, :fat, :decimal, precision: 10, scale: 2
    change_column :foods, :carbo, :decimal, precision: 10, scale: 2

  end
end
