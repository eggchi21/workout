class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :validates_index_new, only: %i[index new]
  before_action :find_diary, only: %i[edit update destroy]
  before_action :find_plan, only: %i[index new edit update]

  def index
    @diaries = Diary.where(user_id: current_user.id).order(entry_on: 'ASC')
    gon.ids = @diaries.map(&:id)
    gon.dates = @diaries.map(&:entry_on)
    gon.kcals = Diary.calc_kcals(@diaries)
    @plan_kcal = @plan.protein * 4 + @plan.fat * 9 + @plan.carbo * 4
    gon.plan_kcal = @plan_kcal
    @diary = Diary.find_by(user_id: current_user.id, entry_on: Date.today)
    @today_kcal = Diary.calc_kcal(@diary) if @diary
  end

  def show; end

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

  def edit; end

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
    flash[:notice] = if @diary.destroy
                       '記録を削除しました'
                     else
                       '記録の削除に失敗しました'
                     end
    redirect_to diaries_path
  end
end

private

def diary_params
  params.require(:diary).permit(
    :entry_on,
    diaryfoods_attributes: %i[id
                              amount
                              _destroy
                              food_id
                              diary_id]
  ).merge(user_id: current_user.id, evaluation: 0)
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

def find_diary
  @diary = Diary.find(params[:id])
end

def find_plan
  @plan = current_user.plans.last
end
