require 'rails_helper'

describe Plan do
  describe '#create' do
    # --- 全部
    it "is valid with a start_weight,target_weight,start_on, target_on, method, protein, fat,carbo, user_id" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", user_id: user.id)
      expect(plan).to be_valid
    end
    # --- 部分欠損
    it "is invalid without start_weight" do
      user = create(:updated_user)
      plan = build(:plan, start_weight: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_weight]).to include("を入力してください")
    end
    it "is invalid without target_weight" do
      user = create(:updated_user)
      plan = build(:plan, target_weight: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:target_weight]).to include("を入力してください")
    end
    it "is invalid without start_on" do
      user = create(:updated_user)
      plan = build(:plan, start_on: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_on]).to include("を入力してください")
    end
    it "is invalid without target_on" do
      user = create(:updated_user)
      plan = build(:plan, start_on: "", method: "lowfat", user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_on]).to include("を入力してください")
    end
    it "is invalid without method" do
      user = create(:updated_user)
      plan = build(:plan, method: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:method]).to include("は一覧にありません")
    end
    it "is invalid without protein" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", protein: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:protein]).to include("を入力してください")
    end
    it "is invalid without fat" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", fat: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:fat]).to include("を入力してください")
    end
    it "is invalid without carbo" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", carbo: nil, user_id: user.id)
      plan.valid?
      expect(plan.errors[:carbo]).to include("を入力してください")
    end
    it "is invalid without user_id" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", carbo: nil, user_id: nil)
      plan.valid?
      expect(plan.errors[:user]).to include("を入力してください")
    end
    # ---start_weight validation
    it "is invalid with start_weight under 0" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", start_weight: -0.1, user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_weight]).to include("は0より大きい値にしてください")
    end
    it "is invalid with start_weight equal 0" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", start_weight: 0, user_id: user.id)
      plan.valid?
      expect(plan.errors[:start_weight]).to include("は0より大きい値にしてください")
    end
    it "is valid with start_weight greater 0" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", start_weight: 0.1, user_id: user.id)
      expect(plan).to be_valid
    end
    # ---target_weight validation
    it "is invalid with target_weight under 0" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", target_weight: -0.1, user_id: user.id)
      plan.valid?
      expect(plan.errors[:target_weight]).to include("は0より大きい値にしてください")
    end
    it "is invalid with target_weight equal 0" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", target_weight: 0, user_id: user.id)
      plan.valid?
      expect(plan.errors[:target_weight]).to include("は0より大きい値にしてください")
    end
    it "is valid with target_weight greater 0" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", target_weight: 0.1, user_id: user.id)
      expect(plan).to be_valid
    end
    # --- start_on validation
    it "is invalid with wrong start_on format(without '/'  )" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", user_id: user.id, start_on: "20191126")
      plan.valid?
      expect(plan.errors[:start_on]).to include("20191126はカレンダーにない日付です")
    end
    # --- target_on validation
    it "is invalid with wrong target_on format(without '/'  )" do
      user = create(:updated_user)
      plan = build(:plan, method: "lowfat", user_id: user.id, target_on: "20191126")
      plan.valid?
      expect(plan.errors[:target_on]).to include("20191126はカレンダーにない日付です")
    end

    it "is invalid with wrong start_on format(with start_on > target_on)" do
      user = create(:user)
      plan = build(:plan, user_id: user.id, start_on: "3019/11/26")
      plan.valid?
      expect(plan.errors[:start_on]).to include(": 開始日は目標日より前の日付を登録できません")
    end
  end
end
