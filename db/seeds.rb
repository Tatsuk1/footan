# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

#   Shop.create(
#     name: "shop#{i}",
#     opentime: "opentime"
#   )
# end

# Post.create(title: 'Nice!',   user_id: 1, book_id: 1)
# Post.create(title: 'Greate!', user_id: 1, book_id: 2)
# Post.create(title: 'Bad',     user_id: 3, book_id: 3)
# Post.create(title: 'No good', user_id: 4, book_id: 3)
# Post.create(title: 'worst',   user_id: 5, book_id: 3)

User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

20.times do |i|
  i += 1
  User.create(
    name: "user#{i}",
    email: "user#{i}@example.com",
    password: "aaaaaa",
    password_confirmation: 'aaaaaa',
    admin: false)
end

20.times do |i|
  i += 1
  Post.create(
    title: "post#{i}",
    content: "今までで#{i}番目に美味しかった",
    image: 'app/assets/images/bread-2796393_1920_2.jpg'
    user_id: i
    shop_id: i
end

# t.string "image"
# t.string "title"
# t.text "content"
# t.bigint "user_id"
# t.bigint "shop_id"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["shop_id"], name: "index_posts_on_shop_id"
# t.index ["user_id"], name: "index_posts_on_user_id"