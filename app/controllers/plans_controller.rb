class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plans_path
    else
      render :new
    end
  end
end

private

def plan_params
  params.require(:plan).permit(:start_weight,:target_weight,:start_on,:target_on,:method,:protein,:fat,:carbo).merge(user_id:current_user.id)
end
