class ReportsController < ApplicationController
  def index
    @reports = Report.where(user_id:current_user.id).order(entry_on: 'ASC')
    @ids = @reports.map(&:id)
    @weights = @reports.map(&:weight)
    @dates = @reports.map{|report| report.entry_on.strftime('%Y/%m/%d') }
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
