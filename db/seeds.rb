# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


admin_user = User.create(name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password', admin: true)
admin_user.save!
admin_user.todos.create(task: "牛乳を買う", duedate: '2021-07-21 17:00')
admin_user.todos.create(task: "役所に行く", duedate: '2021-06-21 10:00')
admin_user.todos.create(task: "髪を切る", duedate: '2021-06-13 13:00')
admin_user.todos.create(task: "ディナーを予約する", duedate: '2021-06-17 18:00')
admin_user.todos.create(task: "ハサミを買う", duedate: '2021-09-04 09:00')
admin_user.todos.create(task: "服を買う", duedate: '2021-06-13 10:00')

User.create(name: '花子', email: 'test2@example.com', password: 'password', password_confirmation: 'password')
User.create(name: '貴子', email: 'test3@example.com', password: 'password', password_confirmation: 'password')
User.create(name: '次郎', email: 'test4@example.com', password: 'password', password_confirmation: 'password')