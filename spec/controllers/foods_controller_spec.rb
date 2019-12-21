require 'rails_helper'

describe FoodsController, type: :controller do
  describe 'GET #index' do
    it "populates an array of food_groups" do
      foods = create_list(:food_ancestry_is_nil, 3)
      get :index
      expect(assigns(:food_groups)).to match(foods)
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
