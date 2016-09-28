puts 'BEGIN Seed Features'
puts '----------------'

FEATURES = ['Garage', 'Calefacción Central']

FEATURES.each do |feature_name|
  Feature.where(name: feature_name).first_or_create()
end

puts "Features count: #{Feature.count}"

puts '----------------'
puts 'END Seed Features'
