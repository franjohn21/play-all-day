# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'francis.john@coloroado.edu', password: 'password')
user.events_created << Event.create({location_name: "Everett Alvarez Junior Park", title: "Let's Play Basketball", latitude: 37.333787, longitude: -121.955933, num_people: 5})
user.events_created << Event.create({location_name: "City Sports Club", title: "Anyone up for a game?", latitude: 37.348935, longitude: -121.919541, num_people: 3})
user.events_created << Event.create({location_name: "Jenny Strand Park", title: "BBall!", latitude: 37.327371, longitude: -122.002968, num_people: 10})
user.events_created << Event.create({location_name: "Homeridge Park", title: "Volleyball!", latitude: 37.335970, longitude: -121.983055, num_people: 5})
user.events_created << Event.create({location_name: "Watson Park", title: "Frisbee anyone?", latitude: 37.358078, longitude: -121.875595, num_people: 2})
user.save!

10.times do 


  User.create(:email => Faker::Internet.email, :password => Faker::Lorem.word) 
end

10.times do
  UserEvent.create(:event_id => Event.all.sample.id, :user_id => User.all.sample.id, :attending => true)
end