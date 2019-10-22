class RemoveTelephoneFromAddress < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :telephone, :string
  end
end
