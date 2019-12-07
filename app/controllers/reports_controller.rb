class ReportsController < ApplicationController
  before_action :set_report, only: [:edit ,:update]
  before_action :authenticate_user!
  def index
    @plan = Plan.where(user_id:current_user.id).last
    if @plan.present? && Date.today < @plan.target_on
      @reports = Report.where(user_id:current_user.id).entry_on_between(@plan.start_on , nil)
      gon.reports = @reports
    else
      @reports = Report.where(user_id:current_user.id).order(entry_on: 'ASC')
      gon.reports = Report.where(user_id:current_user.id).order(entry_on: 'ASC')
    end
    gon.ids = @reports.map(&:id)
    gon.weights = @reports.map(&:weight)
    gon.dates = @reports.map{|report| report.entry_on.strftime('%Y/%m/%d') }
    gon.user_id = current_user.id
    @week_after = Report.ols(@reports) if @reports.length >= 2
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

  def edit
  end

  def update
    if @report.update(report_params)
      flash[:notice] = '更新しました'
      redirect_to user_reports_path
    else
      render :edit
    end
  end
end

private

def set_report
  @report = Report.find(params[:id])
end

def report_params
  params.require(:report).permit(:weight,:entry_on,:text, images: []).merge(user_id: current_user.id)
end
