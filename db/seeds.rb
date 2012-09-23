# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Spend categories
load(Rails.root.join("db","spend_categories_seeds.rb"))

# Income categories
load(Rails.root.join("db","income_categories_seeds.rb"))

# Users and Families
load(Rails.root.join("db","users_and_families_seeds.rb"))

# Spendings, Incomings
load(Rails.root.join("db","spendings_and_incomings_seeds.rb"))
