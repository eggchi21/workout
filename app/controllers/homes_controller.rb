class HomesController < ApplicationController
  def index
    if user_signed_in?
      @today_kcal = Diary.calc_kcal(@diary) if @diary = Diary.find_by(user_id:current_user.id,entry_on:Date.today)
      @today_weight = @report.weight if @report = Report.find_by(user_id:current_user.id,entry_on:Date.today)
    else
      redirect_to about_homes_path
    end
  end
  def about
  end
  def logout
  end
end
