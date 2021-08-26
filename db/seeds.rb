# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = FactoryBot.create(:user, email: 'vlad@dev.com', password: 'password123')
category1 = FactoryBot.create(:category, name: 'Programming')
category2 = FactoryBot.create(:category, name: 'Sport')
category3 = FactoryBot.create(:category, name: 'Books')

FactoryBot.create_list(:post, 15, user: user, categories: [category1])
FactoryBot.create_list(:post, 15, user: user, categories: [category2])
FactoryBot.create_list(:post, 15, user: user, categories: [category3])