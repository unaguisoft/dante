puts 'BEGIN Seed Owners'
puts '----------------'

michael = Owner.where(email: 'michael@jordan.com').first_or_initialize do |owner|
  owner.first_name            = 'Michael'
  owner.last_name             = 'Jordan'
  owner.cellphone             = '2215624432'
  owner.agent                 = User.first
end

larry = Owner.where(email: 'larry@bird.com').first_or_initialize do |owner|
  owner.first_name            = 'Larry'
  owner.last_name             = 'Bird'
  owner.cellphone             = '2214534318'
  owner.agent                 = User.last
end

if michael.new_record?
  michael.save!
  puts "Owner created => #{michael.inspect}"
end

if larry.new_record?
  larry.save!
  puts "Owner created => #{larry.inspect}"
end

puts "Owner count: #{Owner.count}"

puts '----------------'
puts 'END Seed Owners'

