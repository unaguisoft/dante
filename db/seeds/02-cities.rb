puts 'BEGIN Seed Cities'
puts '----------------'

CITIES = ['LA PLATA', 'GONNET', 'CITY BELL', 'BERISSO', 'ENSENADA', 'RINGUELET', 'TOLOSA']

CITIES.each do |city_name|
  City.where(name: city_name.upcase).first_or_create()
end

puts "Cities count: #{City.count}"

puts '----------------'
puts 'END Seed Cities'
