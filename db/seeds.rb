# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin
User.create(
  email: 'ronald.tingchaleun@gmail.com',
  password: 'password',
  admin: true,
)

# Create users
20.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    admin: false,
  )
end

# Create posts
20.times do
  Post.create(
    title: Faker::Book.title,
    body: Faker::Lorem.sentence,
    views: 0,
    user_id: 1,
  )
end

# Create comments
20.times do
  Comment.create(
    body: Faker::Lorem.sentence,
    post_id: 1,
    user_id: 1,
  )
end
