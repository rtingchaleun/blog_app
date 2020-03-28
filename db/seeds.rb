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
4.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    admin: false,
  )
end

# Create posts
users = User.all
users.each do |user|
  2.times do
    post = Post.new
    post.title = Faker::Book.title
    post.body = Faker::Lorem.sentence
    post.user_id = user.id
    post.save

    # if saving a local file
    # post.banner.attach(io: File.open('app/assets/images/chess.jpg'), filename: 'chess.jpg', content_type: 'image/jpg')

    # if saving an image url
    num = rand(300..500)
    post.banner.attach(io: open("https://i.picsum.photos/id/#{num}/900/600.jpg"), filename: "banner-#{num}.jpg", content_type: 'image/jpg')
    
  end
end

# Create comments
posts = Post.all
posts.each do |post|
  users.each do |user|
    Comment.create(
      body: Faker::Lorem.sentence,
      post_id: post.id,
      user_id: user.id,
    )
  end
end
