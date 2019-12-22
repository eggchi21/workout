require 'rails_helper'

describe Address do
  describe '#create' do
    # --- 全部
    it "is valid with all" do
      user = create(:user)
      address = build(:address, user_id: user.id)
      expect(address).to be_valid
    end
    # --- 部分欠損
    it "is invalid without a postcode" do
      address = build(:address, postcode: "")
      address.valid?
      expect(address.errors[:postcode]).to include("を入力してください")
    end
    it "is invalid without a prefecture_code" do
      address = build(:address, prefecture_code: "")
      address.valid?
      expect(address.errors[:prefecture_code]).to include("を入力してください")
    end
    it "is invalid without a city" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end
    it "is invalid without a address1" do
      address = build(:address, address1: "")
      address.valid?
      expect(address.errors[:address1]).to include("を入力してください")
    end
    it "is invalid without a address2" do
      address = build(:address, address2: "")
      expect(address).to be_valid
    end
  end
end
