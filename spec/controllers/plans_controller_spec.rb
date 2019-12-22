require 'rails_helper'

describe PlansController, type: :controller do
  describe 'GET #new' do
    # it "renders the :new template" do
    #   get :new
    #   expect(response).to render_template :new
    # end
  end
  describe 'GET #index' do
    it "populates an array of tweets ordered by created_at DESC" do
      plans = create_list(:plan, 3, method: "lowfat")
      get :index
      expect(assigns(:plans)).to match(plans.sort { |a, b| b.created_at <=> a.created_at })
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
