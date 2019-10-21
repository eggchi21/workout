class ReportsController < ApplicationController
  def index
    @reports = Report.order('id DESC')
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to root_path
    else
      render :new
    end
  end
end

private

def report_params
  params.require(:report).permit(:weight,:entry_on,:text, images: [])
end