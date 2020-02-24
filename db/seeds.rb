# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# movies = 5.times do
# Movie.create(title: Faker::Food.dish, plot: Faker::Food.description)
# end
movies  = FactoryBot.create_list(:movie, 10)
seasons = FactoryBot.create_list(:season_with_episodes, 10)
user    = FactoryBot.create(:user)

movies.map do |movie|
  FactoryBot.create(:purchase, user: user, product: movie)
end

seasons.map do |season|
  FactoryBot.create(:purchase, :expired, user: user, product: season)
end
