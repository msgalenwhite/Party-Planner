require "faker"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
10.times do
  name = Faker::TheFreshPrinceOfBelAir.character.split(" ")

  Friend.create(first_name: "#{name[0]}", last_name: "#{name[1]}")
end


7.times do
  celebrity = Faker::TheFreshPrinceOfBelAir.celebrity
  party_name = "#{celebrity}'s Party"
  party_location = "#{celebrity}'s House"
  party_description = "Guaranteed to make you say, '#{Faker::TheFreshPrinceOfBelAir.quote}'"

  Party.create(name: party_name, location: party_location, description: party_description)
end

# how do I make sure that I don't have repeats of combinations?
100.times do
  random_person_id = 1 + rand(20)
  random_party_id = 1 + rand(7)

  InvitedFriend.create(friend_id: random_person_id, party_id: random_party_id)
end
