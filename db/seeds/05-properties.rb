puts 'BEGIN Seed Properties'
puts '----------------'

casa_blanca = Property.where(title: 'Casa Blanca').first_or_initialize do |prop|
  prop.kind = Property.kinds['residencial']
  prop.status = Property.statuses['activo']
  prop.property_status = Property.property_statuses['sin_habitar']
  prop.property_kind = Property.property_kinds['casa']
  prop.price = 1_000_000
  prop.currency = Property.currencies[:ars]
  prop.address = 'Washington 123'
  prop.title = 'Casa Blanca'
  prop.number_of_bedrooms = 2
  prop.number_of_bathrooms = 2
  prop.city = City.find_by(name: 'LA PLATA')
  prop.owner = Owner.find_by(email: 'michael@jordan.com')
  prop.user = User.find_by(email: 'agent@agent.com')
end

if casa_blanca.new_record?
  casa_blanca.save!
  puts "Property created => #{casa_blanca.inspect}"
end



casa_rosada = Property.where(title: 'Casa Rosada').first_or_initialize do |prop|
  prop.kind = Property.kinds['residencial']
  prop.status = Property.statuses['activo']
  prop.property_status = Property.property_statuses['sin_habitar']
  prop.property_kind = Property.property_kinds['casa']
  prop.price = 500_000
  prop.currency = Property.currencies[:ars]
  prop.address = 'Buenos Aires 123'
  prop.title = 'Casa Rosada'
  prop.number_of_bedrooms = 1
  prop.number_of_bathrooms = 1
  prop.city = City.find_by(name: 'GONNET')
  prop.owner = Owner.find_by(email: 'larry@bird.com')
  prop.user = User.find_by(email: 'admin@admin.com')
end

if casa_rosada.new_record?
  casa_rosada.save!
  puts "Property created => #{casa_rosada.inspect}"
end

puts "Property count: #{Property.count}"

puts '----------------'
puts 'END Seed Properties'

