class DiariesController < ApplicationController
  def index
    # if Diary.find_by(user_id: current_user.id,entry_on: Date.today)
    #   @diary = Diary.find_by(user_id: current_user.id,entry_on: Date.today)
    # else
    #   @diary = Diary.create(user_id: current_user.id,entry_on: Date.today,evaliation:0)
    # end
  end

  def show

  end

  def new
    @diary = Diary.new
    @diary.diaryfoods.build
    @food = Food.where(ancestry:nil)
  end

  def create
    binding.pry
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to root_path
    else
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