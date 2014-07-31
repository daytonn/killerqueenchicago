puts "Seeding database..."
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

default_team = Team.create!(name: "Killer Queens")
default_user = User.create!(
  email: "daytonn@gmail.com",
  username: "daytonn",
  password: "password",
  password_confirmation: "password",
  team: default_team)

default_user.update_attribute("password", "p")
default_user.confirm!
default_team.captain = default_user
default_team.save

puts "Seeds loaded"
