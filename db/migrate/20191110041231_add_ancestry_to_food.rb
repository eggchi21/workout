class AddAncestryToFood < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :ancestry, :string
  end
end
