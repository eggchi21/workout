class FoodsController < ApplicationController
  def index
    @food_groups = Food.where(ancestry: nil)
  end

  def show
    @food = Food.find(params[:id])
  end
end
