class ReportsController < ApplicationController
  def index
    @reports = Report.where(user_id:current_user.id).order(entry_on: 'ASC')
    gon.reports = Report.where(user_id:current_user.id).order(entry_on: 'ASC')
    gon.ids = @reports.map(&:id)
    gon.weights = @reports.map(&:weight)
    gon.dates = @reports.map{|report| report.entry_on.strftime('%Y/%m/%d') }
    gon.user_id = current_user.id
    @week_after = Report.ols(@reports)
  end

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to user_reports_path
    else
      render :new
    end
  end
end

private

def report_params
  params.require(:report).permit(:weight,:entry_on,:text, images: []).merge(user_id: current_user.id)
end
