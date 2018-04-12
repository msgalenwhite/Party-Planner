require "faker"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
20.times do
  first_name = Faker::Name.unique.first_name

  last_name = Faker::Name.unique.last_name

  Friend.create(first_name: first_name, last_name: last_name)
end

# # if I wanted to clear out my record of unique names:
# Faker::Pokemon.unique.clear #clears specific library
# Faker::UniqueGenerator.clear # Clears used values for all generators

10.times do
  celebrity = Faker::Pokemon.name
  party_name = "It's a #{celebrity} Party!"
  party_location = Faker::Pokemon.location
  party_description = "Guaranteed to make you #{Faker::Pokemon.unique.move}"

  Party.create(name: party_name, location: party_location, description: party_description)
end


40.times do
  random_person_id = 1 + rand(20)
  random_party_id = 1 + rand(10)

  InvitedFriend.create(friend: Friend.find(random_person_id), party: Party.find(random_party_id))
end
