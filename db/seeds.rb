require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
10.times do
  User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: '12345678',
      password_confirmation: '12345678'
  )
end

20.times do |index|
  Senryu.create(
      user: User.offset(rand(User.count)).first,
      kamigo: "上五#{index}",
      nakashichi: "中七#{index}",
      shimogo: "下五#{index}"
  )
end

# 10.times do
#   Comment.create!(
#     user: User.offset(rand(User.count)).first,
#     senryu: Senryu.offset(rand(Senryu.count)).first,
#     content: Faker::Lorem.sentence(word_count: 5)
#   )
# end

# 10.times do
#   user = User.offset(rand(User.count)).first
#   senryu = Senryu.offset(rand(Senryu.count)).first
  
#   # 同じ user_id と senryu_id の組み合わせが既に存在するかチェック
#   unless Favorite.exists?(user_id: user.id, senryu_id: senryu.id)
#     Favorite.create!(user: user, senryu: senryu)
#   end
# end