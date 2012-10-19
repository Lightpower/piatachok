# encoding: UTF-8
users_array = [
  %w{test1 Вася Пупкин vasya@poopking.com 123456},
  %w{test2 Маня Пупкина mary@poopking.com 123456},
  %w{test3 Иван Иванов ivan.ivanoff@example.com 123456}
]

user = User.create(login: users_array[0][0], first_name: users_array[0][1], last_name: users_array[0][2],
  email: users_array[0][3], password: users_array[0][4], password_confirmation: users_array[0][4])
user.reload
user.family.name = "Семья Пупкиных"
user.family.save

User.create(login: users_array[1][0], first_name: users_array[1][1], last_name: users_array[1][2],
  email: users_array[1][3], password: users_array[1][4], password_confirmation: users_array[1][4],
  family_id: user.family_id)

User.create(login: users_array[2][0], first_name: users_array[2][1], last_name: users_array[2][2],
  email: users_array[2][3], password: users_array[2][4], password_confirmation: users_array[2][4])
