@entry_on = Date.today
@weight = 70
(1..30).each do |n|
  Report.create!(weight:@weight + rand(0.0..2.9).round(1),
                entry_on:@entry_on - rand(1..4),
                text:"",
                user_id:1,
  )

  report = Report.find(n)

  @weight = report.weight
  @entry_on = report.entry_on
  report.images.attach(io: File.open("#{Rails.root}/db/fixtures/sample.jpeg"), filename: "test#{n}")
end