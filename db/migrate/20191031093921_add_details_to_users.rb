class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sex, :integer
    add_column :users, :age, :integer
    add_column :users, :height, :integer
    add_column :users, :activity, :integer
  end
end
