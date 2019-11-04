class PlansController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  def index
    @plans = Plan.all
  end

  def new
    if current_user.sex.present?
      @plan = Plan.new
      gon.user = current_user
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      @report = Report.where(user_id:current_user.id,entry_on:plan_params[:start_on])
      if @report.present?
        @report.update(weight:plan_params[:start_weight])
      else
        @report = Report.new(
          weight:plan_params[:start_weight],
          entry_on:plan_params[:start_on],
          text:'今日からがんばります！',
          user_id: current_user.id
        )
        @report.save
      end
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
