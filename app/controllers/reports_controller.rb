class ReportsController < ApplicationController
  before_action :authenticate_user!
  def index
    @plan = Plan.where(user_id:current_user.id).last
    if @plan.present?
      @reports = Report.where(user_id:current_user.id).entry_on_between(@plan.start_on , nil)
      gon.reports = Report.where(user_id:current_user.id).entry_on_between(@plan.start_on , nil)
    else
      @reports = Report.where(user_id:current_user.id).order(entry_on: 'ASC')
      gon.reports = Report.where(user_id:current_user.id).order(entry_on: 'ASC')
    end
    gon.ids = @reports.map(&:id)
    gon.weights = @reports.map(&:weight)
    gon.dates = @reports.map{|report| report.entry_on.strftime('%Y/%m/%d') }
    gon.user_id = current_user.id
    @week_after = Report.ols(@reports) if @reports.length >=2

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

  def edit
  end

  def update

  end

private

def report_params
  params.require(:report).permit(:weight,:entry_on,:text, images: []).merge(user_id: current_user.id)
end
