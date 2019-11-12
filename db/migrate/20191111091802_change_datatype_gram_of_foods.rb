class ChangeDatatypeGramOfFoods < ActiveRecord::Migration[5.2]
  def change
    change_column :foods, :gram, :decimal, precision: 10, scale: 1
  end
end
