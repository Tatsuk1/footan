# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
  i += 1
  User.create(
    name: "user#{i}",
    email: "user#{i}@example.com",
    password_digest: 'password'
    
  )

  Shop.create(
    name: "shop#{i}",
    opentime: "opentime"
  )
end

Post.create(title: 'Nice!',   user_id: 1, book_id: 1)
Post.create(title: 'Greate!', user_id: 1, book_id: 2)
Post.create(title: 'Bad',     user_id: 3, book_id: 3)
Post.create(title: 'No good', user_id: 4, book_id: 3)
Post.create(title: 'worst',   user_id: 5, book_id: 3)