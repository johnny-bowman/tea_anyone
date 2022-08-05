# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

user_1 = User.create!(first_name: "fake", last_name: "person", email: "fake@nah.com", address: "123 Fake St")

tea_1 = Tea.create!(title: 'Green Tea', description: 'maaan this is good tea', temp: 177, brew_time: 2, price: 5.50)
tea_2 = Tea.create!(title: 'Black Tea', description: 'wowza black tea is great', temp: 212, brew_time: 4, price: 6.75)
tea_3 = Tea.create!(title: 'White Tea', description: 'mmmmm tea', temp: 180, brew_time: 3, price: 4.99)
