puts 'BEGIN Seed Users'
puts '----------------'

admin = User.where(email: 'admin@admin.com').first_or_initialize do |user|
  user.name                  = 'Admin'
  user.role                  = 'admin'
  user.password              = '123123123'
  user.password_confirmation = '123123123'
end

agent = User.where(email: 'agent@agent.com').first_or_initialize do |user|
  user.name                  = 'Agent'
  user.role                  = 'agent'
  user.password              = '123123123'
  user.password_confirmation = '123123123'
end

if admin.new_record?
  admin.save!
  puts 'User created => admin@admin.com, 12313213'
end

if agent.new_record?
  agent.save!
  puts 'User created => agent@agent.com, 12313213'
end

puts "User count: #{User.count}"

puts '----------------'
puts 'END Seed Users'

