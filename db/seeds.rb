# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
c1 = Category.create({title: "Семья"})
c2 = Category.create({title: "Работа"})

с1 = Todo.create({text: "Купить молоко",isCompleted: false})
c2 = Todo.create({text: "Купить водки",isCompleted: false})