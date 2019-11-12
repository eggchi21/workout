Dir.glob(File.join(Rails.root, 'db', 'seeds', 'user.rb')) do |file|
  load(file)
end
# Dir.glob(File.join(Rails.root, 'db', 'seeds', 'report.rb')) do |file|
#   load(file)
# end
