class ChangeWeightToReport < ActiveRecord::Migration[5.2]
  def change
    change_column :reports, :weight, :decimal, precision: 4, scale: 1
  end
end
