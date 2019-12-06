RSpec.describe SocialProfile, type: :model do
  describe  '#create' do
    before do
      Rails.application.env_config['omniauth.auth'] = facebook_mock
    end
    it "create socialprofile_user" do
      user = create(:user, email: 'sample@test.com')
      socialprofile = SocialProfile.create(provider: 'facebook', uid: '12345', user_id: user.id)
      expect(socialprofile).to be_valid
    end

    it "same provider & uid" do
      user = create(:user, email: 'sample@test.com')
      SocialProfile.create(provider: 'facebook', uid: '12345', user_id:user.id)
      socialprofile = SocialProfile.create(provider: 'facebook', uid: '12345', user_id: user.id)
      socialprofile.valid?
      expect(socialprofile.errors[:uid]).to include("はすでに存在します")
    end

    it "different provider same uid" do
      user = create(:user, email: 'sample@test.com')
      SocialProfile.create(provider: 'facebook', uid: '12345', user_id:user.id)
      socialprofile = SocialProfile.create(provider: 'google_oauth2', uid: '12345', user_id: user.id)
      expect(socialprofile).to be_valid
    end
  end
end