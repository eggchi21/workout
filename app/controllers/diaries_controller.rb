class DiariesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show

  end

  def new
    @diary = Diary.new
    @diary.diaryfoods.build
    @food = Food.where(ancestry: nil)
    @plan = current_user.plans.last
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
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