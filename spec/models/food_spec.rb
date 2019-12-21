require 'rails_helper'

describe Food do
  describe '#create' do
    # --- 全部
    it "is valid with all" do
      food = build(:food)
      expect(food).to be_valid
    end
    # --- 部分欠損
    it "is invalid without a name" do
      food = build(:food, name: "")
      food.valid?
      expect(food.errors[:name]).to include("を入力してください")
    end
    it "is invalid without a protein" do
      food = build(:food, protein: "")
      food.valid?
      expect(food.errors[:protein]).to include("を入力してください")
    end
    it "is invalid without a fat" do
      food = build(:food, fat: "")
      food.valid?
      expect(food.errors[:fat]).to include("を入力してください")
    end
    it "is invalid without a carbo" do
      food = build(:food, carbo: "")
      food.valid?
      expect(food.errors[:carbo]).to include("を入力してください")
    end
    it "is invalid without a unit" do
      food = build(:food, unit: "")
      food.valid?
      expect(food.errors[:unit]).to include("を入力してください")
    end
    it "is invalid without a image_url" do
      food = build(:food, image_url: "")
      food.valid?
      expect(food.errors[:image_url]).to include("を入力してください")
    end
    it "is invalid without a gram" do
      food = build(:food, gram: "")
      food.valid?
      expect(food.errors[:gram]).to include("を入力してください")
    end
    it "is invalid without a kcal" do
      food = build(:food, kcal: "")
      food.valid?
      expect(food.errors[:kcal]).to include("を入力してください")
    end
    it "is valid without protein, fat, carbo, unit, gram, image_url, kcal, ancestry" do
      food = build(:food, protein: "", fat: "", carbo: "", unit: "", gram: "", image_url: "", kcal: "", ancestry: nil)
      expect(food).to be_valid
    end
  end
end
