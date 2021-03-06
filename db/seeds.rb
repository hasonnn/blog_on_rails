# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all
Comment.destroy_all
User.destroy_all

PASSWORD = 'supersecret'
super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  is_admin: true
)
10.times do 
    first_name= Faker:: Name.first_name
    last_name= Faker::Name.last_name
    User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}.#{last_name}@example.com",
    password: PASSWORD
    )
end
users = User.all

25.times do
    created_at = Faker::Date.backward(days:365 * 5)

    p = Post.create(
        title: Faker::TvShows::GameOfThrones.character,
        body: Faker::Lorem.sentence(word_count: 55),
        created_at: created_at,
        updated_at: created_at,
        user: users.sample

    )
    if p.persisted?
        p.comments = rand(1..10).times.map do
            Comment.new(body: Faker::GreekPhilosophers.quote, user: users.sample)
        end
    end
end

posts = Post.all
comments = Comment.all

puts "Generated #{posts.count} posts!"
puts "Generated #{comments.count} comments!"
puts "Generated #{users.count} users!"