class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :validates_index_new, only: [:index,:new]
  before_action :set_diary, only: [:edit,:update,:destroy]
  before_action :set_plan, only: [:index,:new,:edit,:update]

  def index
    @diaries =  Diary.where(user_id: current_user.id).order(entry_on: 'ASC')
    gon.ids = @diaries.map(&:id)
    gon.dates = @diaries.map(&:entry_on)
    gon.kcals = Diary.calc_kcals(@diaries)
    @plan_kcal = @plan.protein * 4 + @plan.fat * 9 + @plan.carbo * 4
    gon.plan_kcal = @plan_kcal
    @today_kcal = Diary.calc_kcal(@diary) if @diary = Diary.find_by(entry_on:Date.today)
  end

  def show

  end

  def new
    @diary = Diary.new
    @diary.diaryfoods.build
    @food = Food.where(ancestry: nil)
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      flash[:notice] = '食事を記録しました!'
      redirect_to diaries_path
    else
      @plan = current_user.plans.last
      render :new
    end
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
      flash[:notice] = '更新しました'
      redirect_to diaries_path
    else
      @plan = current_user.plans.last
      render :edit
    end
  end

  def destroy
    if @diary.destroy
      flash[:notice] = '記録を削除しました'
      redirect_to diaries_path
    else
      flash[:notice] = '記録の削除に失敗しました'
      redirect_to diaries_path
    end
  end
end

private

def diary_params
  params.require(:diary).permit(
    :entry_on,
    diaryfoods_attributes: [:id,
                            :amount,
                            :_destroy,
                            :food_id,
                            :diary_id
                            ]
    ).merge(user_id: current_user.id,evaluation:0)
end

def validates_index_new
  if current_user.sex.present? && current_user.age.present? && current_user.activity.present?
    if current_user.plans.last.blank? || Date.today > current_user.plans.last.target_on
      flash[:notice] = '目標を新規で登録してから食事を記録しましょう!'
      redirect_to new_plan_path
    end
  else
    flash[:notice] = 'ユーザー情報が足りないようです。身長や性別を教えてください!'
    redirect_to edit_user_path(current_user)
  end
end

def set_diary
  @diary = Diary.find(params[:id])
end

def set_plan
  @plan = current_user.plans.last
end