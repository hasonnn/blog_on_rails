# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all
Comment.destroy_all

50.times do
    created_at = Faker::Date.backward(days:365 * 5)

    p = Post.create(
        title: Faker::TvShows::GameOfThrones.character,
        body: Faker::Lorem.sentence(word_count: 55)
    )
    if p.persisted?
        p.comments = rand(1..10).times.map do
            Comment.new(body: Faker::GreekPhilosophers.quote)
        end
    end
end

posts = Post.all
comments = Comment.all

puts "Generated #{posts.count} posts!"
puts "Generated #{comments.count} comments!"