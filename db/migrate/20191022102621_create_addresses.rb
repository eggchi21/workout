class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references  :user,                      null: false, foreign_key: true
      t.integer     :postcode,                  null: false
      t.integer     :prefecture_code,                null: false
      t.string      :city,                      null: false
      t.string      :address1,                   null: false
      t.string      :address2
      t.string      :telephone,                 unique: true
      t.timestamps
    end
  end
end
