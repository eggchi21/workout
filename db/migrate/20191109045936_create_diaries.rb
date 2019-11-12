class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.date :entry_on, null: false
      t.integer :evaliation
      t.references :user,foreign_key: true
      t.timestamps
    end
  end
end
