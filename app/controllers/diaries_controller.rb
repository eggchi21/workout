class DiariesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show

  end

  def new
    if current_user.sex.present? && current_user.age.present? && current_user.activity.present?
      if current_user.plans.last.present? && Date.today < current_user.plans.last.target_on
        @diary = Diary.new
        @diary.diaryfoods.build
        @food = Food.where(ancestry: nil)
        @plan = current_user.plans.last
      else
        flash[:notice] = '目標を新規で登録してから食事を記録しましょう!'
        redirect_to new_plan_path
      end
    else
      flash[:notice] = 'ユーザー情報が足りないようです。身長や性別を教えてください!'
      redirect_to edit_user_path(current_user)
    end
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      flash[:notice] = '食事を記録しました!'
      redirect_to root_path
    else
      @plan = current_user.plans.last
      render :new
    end
  end

  def destroy

  end
end

private

def diary_params
  params.require(:diary).permit(
    :entry_on,
    diaryfoods_attributes: [:id,
    :amount,
    :food_id,
    :diary_id]
    ).merge(user_id: current_user.id,evaluation:0)
end