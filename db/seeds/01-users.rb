puts 'BEGIN Seed Users'
puts '----------------'

admin = User.where(email: 'admin@admin.com').first_or_initialize do |user|
  user.name                  = 'Admin'
  user.password              = '123123123'
  user.password_confirmation = '123123123'
end
if admin.new_record?
  admin.save!
  puts 'User created => admin@admin.com, 12313213'
end

puts "User count: #{User.count}"

puts '----------------'
puts 'END Seed Users'

