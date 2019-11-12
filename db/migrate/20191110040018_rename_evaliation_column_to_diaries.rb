class RenameEvaliationColumnToDiaries < ActiveRecord::Migration[5.2]
  def change
    rename_column :diaries, :evaliation, :evaluation
  end
end
