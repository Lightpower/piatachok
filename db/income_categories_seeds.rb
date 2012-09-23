# encoding: UTF-8
%w{Зарплата Подарок Прочее}.each { |item| IncomeCategory.create(name: item) }