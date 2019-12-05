class CreateSocialProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :social_profiles do |t|
      t.integer :user_id, foreign_key: true
      t.string  :uid
      t.string  :provider
      t.timestamps
    end
    add_index :social_profiles, [:provider, :uid], unique: true
  end
end
