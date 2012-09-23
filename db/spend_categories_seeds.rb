# encoding: UTF-8
%w{Продукты Транспорт Досуг Прочее}.each { |item| SpendCategory.create(name: item) }
