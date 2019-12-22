class PlansController < ApplicationController
  before_action :set_plan, only: %i[show destroy edit update]
  before_action :authenticate_user!, except: [:index]
  def index
    @plans = Plan.all.order(created_at: :desc)
  end

  def show
    @plans = Plan.where(user_id: @plan.user.id).where.not(id: @plan.id)
  end

  def new
    if current_user.sex.present? && current_user.age.present? && current_user.activity.present?
      if current_user.plans.last.blank? || Date.today > current_user.plans.last.target_on
        @plan = Plan.new
        gon.user = current_user
      else
        flash[:notice] = 'ユーザー情報が更新されました。あなたの目標に変更はありませんか?'
        redirect_to plan_path(current_user.plans.last)
      end
    else
      flash[:notice] = 'ユーザー情報が足りないようです。身長や性別を教えてください!'
      redirect_to edit_user_path(current_user)
    end
  end

  def edit
    gon.user = current_user
  end

  def update
    if @plan.update(plan_params)
      flash[:notice] = '目標を更新しました。がんばってくださいね!'
      redirect_to plans_path
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = if @plan.destroy
                       '目標を削除しました'
                     else
                       '目標の削除に失敗しました'
                     end
    redirect_to plans_path
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      @report = Report.where(user_id: current_user.id, entry_on: plan_params[:start_on])
      if @report.present?
        @report.update(weight: plan_params[:start_weight])
      else
        @report = Report.new(
          weight: plan_params[:start_weight],
          entry_on: plan_params[:start_on],
          text: '今日からがんばります！',
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

def set_plan
  @plan = Plan.find(params[:id])
end

def plan_params
  params.require(:plan).permit(:start_weight, :target_weight, :start_on, :target_on, :method, :protein, :fat, :carbo).merge(user_id: current_user.id)
end
