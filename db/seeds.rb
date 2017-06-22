require 'faker'

5.times do
  User.create!(
    email:    Faker::Internet.email ,
    password: 'password'
  )
end
users = User.all

50.times do
  Wiki.create!(
    user: users.sample,
    title:  Faker::Friends.location,
    body:   Faker::Friends.quote
  )
end

topics = Wiki.all

# Create an admin user
admin = User.create!(
  email:    'admin@example.com',
  password: 'password',
  role:     'admin'
)

# Create a member
member = User.create!(
  email:    'member@example.com',
  password: 'password'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
