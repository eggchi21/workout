require 'rails_helper'

describe User do
  describe '#create' do
    # --- 全部
    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end
    # --- 部分欠損
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("を入力してください")
    end

    # --- email validation
    it "is invalid with wrong email format(without '@')" do
      user = build(:user, email: "tester1.gmail.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with wrong email format(without characters before @)" do
      user = build(:user, email: "@gmail.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with wrong email format(without characters after @)" do
      user = build(:user, email: "tester1@")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with wrong email format(last character is number)" do
      user = build(:user, email: "tester1@gmail.com1")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with wrong email format(without '.')" do
      user = build(:user, email: "tester1@gmailcom")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with wrong email format(with japanese characters)" do
      user = build(:user, email: "テスター@gmail.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:another_user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # --- nickname validation
    it "is invalid with a nickname that has more than 20 characters " do
      user = build(:user, nickname: "012345678901234567890")
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end

    it "is valid with a nickname that has less than 20 characters " do
      user = build(:user, nickname: "01234567890123456789")
      expect(user).to be_valid
    end

    # --- password & password_confirmation validation
    it "is valid with a password that has more than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワード(最低6文字)の入力が一致しません", "を入力してください")
    end
  end
end