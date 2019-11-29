require 'rails_helper'

describe Plan do
  describe '#create' do
    # --- 全部
    it "is valid with a start_weight,target_weight,start_on, target_on, method, protein, fat,carbo, user_id" do
      user = create(:updated_user)
      plan = build(:plan,method:"lowfat",user_id: user.id)
      expect(plan).to be_valid
    end
    # --- 部分欠損
    it "is invalid without start_weight" do
      user = create(:updated_user)
      plan = build(:plan,start_weight: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_weight]).to include("を入力してください")
    end
    it "is invalid without target_weight" do
      user = create(:updated_user)
      plan = build(:plan,target_weight: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:target_weight]).to include("を入力してください")
    end
    it "is invalid without start_on" do
      user = create(:updated_user)
      plan = build(:plan,start_on: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_on]).to include("を入力してください")
    end
    it "is invalid without target_on" do
      user = create(:updated_user)
      plan = build(:plan,start_on: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_on]).to include("を入力してください")
    end
    it "is invalid without method" do
      user = create(:updated_user)
      plan = build(:plan,method: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:method]).to include("は一覧にありません")
    end
    it "is invalid without protein" do
      user = create(:updated_user)
      plan = build(:plan,protein: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:protein]).to include("を入力してください")
    end
    it "is invalid without fat" do
      user = create(:updated_user)
      plan = build(:plan,fat: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:fat]).to include("を入力してください")
    end
    it "is invalid without carbo" do
      user = create(:updated_user)
      plan = build(:plan,carbo: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:carbo]).to include("を入力してください")
    end
    it "is invalid without user_id" do
      user = create(:updated_user)
      plan = build(:plan,carbo: nil, user_id: nil)
      plan.valid?
      expect(plan.errors[:user]).to include("を入力してください")
    end
    # ---start_weight
  end

end