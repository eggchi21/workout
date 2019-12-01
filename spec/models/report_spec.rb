require 'rails_helper'

describe Report do
  describe '#create' do
    # --- 全部
    it "is valid with a weight, entry_on, text, user_id" do
      user = create(:user)
      report = build(:report,user_id: user.id)
      expect(report).to be_valid
    end
    # --- 部分欠損
    it "is invalid without a weight" do
      user = create(:user)
      report = build(:report,user_id: user.id , weight: "")
      report.valid?
      expect(report.errors[:weight]).to include("を入力してください")
    end

    it "is invalid without a entry_on" do
      user = create(:user)
      report = build(:report,user_id: user.id , entry_on: "")
      report.valid?
      expect(report.errors[:entry_on]).to include("はYYYY/MM/DDの形式で記載してください")
    end

    it "is valid without a text" do
      user = create(:user)
      report = build(:report,user_id: user.id , text: "")
      report.valid?
      expect(report).to be_valid
    end

    # --- entry_on validation datepickerだと文字入力はできないので/を消すパターンのみ
    it "is invalid with wrong entry_on format(without '/'  )" do
      user = create(:user)
      report = build(:report,user_id: user.id , entry_on: "20191126")
      report.valid?
      expect(report.errors[:entry_on]).to include("20191126はカレンダーにない日付です")
    end

    it "is invalid with wrong entry_on format(with future date)" do
      user = create(:user)
      report = build(:report,user_id: user.id , entry_on: "3019/11/26")
      report.valid?
      expect(report.errors[:entry_on]).to include(": 今日以降の日付は登録できません")
    end

  end
end