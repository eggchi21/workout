require 'csv'

CSV.generate do |csv|
  column_names = %w[日付 体重]
  csv << column_names
  @reports.each do |report|
    column_values = [
      report.entry_on,
      report.weight
    ]
    csv << column_values
  end
end
