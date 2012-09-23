# encoding: UTF-8
operations = [
    [ 100000, IncomeCategory.first.id,  Date.today.beginning_of_month - 1.month,         ""],
    [-1000,   SpendCategory.first.id,   Date.today.beginning_of_month - 1.month + 1.day, ""],
    [-10000,  SpendCategory.all[1].id,  Date.today.beginning_of_month - 1.month + 2.day, ""],
    [-12300,  SpendCategory.first.id,   Date.today.beginning_of_month - 1.month + 2.day, "Какой-то комментарий"],
    [-2155,   SpendCategory.all[2].id,  Date.today.beginning_of_month - 1.month + 3.day, ""],
    [-150,    SpendCategory.first.id,   Date.today.beginning_of_month - 1.month + 3.day, ""],
    [-900,    SpendCategory.first.id,   Date.today.beginning_of_month - 1.month + 4.day, ""],
    [-1000,   SpendCategory.first.id,   Date.today.beginning_of_month - 1.month + 4.day, ""],
]

User.all.each do |user|
  operations.each do |oper|
    sql = "insert into operations(type, amount, category_id, user_id, created_by, comment, created_at, updated_at, family_id) values(" +
        "'MoneyOperation'," +
        "'#{oper[0] + ((oper[0] > 0 ? 1 : -1) * user.id * 200)}'," +
        "#{oper[1]}," +
        "#{user.id}," +
        "#{user.id}," +
        "'#{oper[3]}'," +
        "'#{oper[2].strftime("%D")}'," +
        "'#{oper[2].strftime("%D")}'," +
        "#{user.family_id})"
    ActiveRecord::Base.connection.execute(sql)
  end
end