class AddColumnToFood < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :kcal, :integer
  end
end
