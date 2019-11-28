require 'rails_helper'

describe Plan do
  describe '#create' do
    # --- 全部
    it "is valid with a start_weight,target_weight,start_on, target_on, method, protein, fat,carbo, user_id" do
      user = create(:updated_user)
      plan = build(:plan,user_id: user.id)
      expect(plan).to be_valid
    end

    # --- 全部
    it "is valid with a start_weight,target_weight,start_on, target_on, method, protein, fat,carbo, user_id" do
      user = create(:user)
      plan = build(:plan,user_id: user.id)
      expect(plan).to be_valid
    end
  end

end