class CreateDiaryfoods < ActiveRecord::Migration[5.2]
  def change
    create_table :diaryfoods do |t|
      t.references :diary, foreign_key: true
      t.references :food, foreign_key: true
      t.decimal :amount,precision: 10, scale: 2
      t.timestamps
    end
  end
end
