# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Reservation.destroy_all
Listing.destroy_all
User.destroy_all
City.destroy_all

cities = ["Montpellier", "Marseille", "Paris", "Tours", "Rennes", "Toulouse", "Nantes", "Strasbourg", "Lille", "Lyon"]
cities_zip = ["34000", "13000", "75000", "37000", "35000", "31000", "44000", "67000", "59000","69000"]
bool = [true, false]

20.times do
	user = User.create!(
		email: Faker::Internet.free_email,
		phone_number: "+33" + rand(1..9).to_s + Faker::PhoneNumber.subscriber_number(length: 8),
		description: Faker::Quote.most_interesting_man_in_the_world
		)
end

n = 0
10.times do
	City.create!(
	name: cities[n],
	zip_code: cities_zip[n]
	)
	n+=1
end

50.times do
	Listing.create!(
		available_beds: rand(1..6),
		price: rand(15..250),
		description: Faker::TvShows::GameOfThrones.quote + "\n" + Faker::TvShows::GameOfThrones.quote + "n" + Faker::TvShows::GameOfThrones.quote,
		has_wifi: bool[rand(0..1)],
		welcome_message: Faker::TvShows::GameOfThrones.quote + "\n" + Faker::TvShows::GameOfThrones.quote + "n" + Faker::TvShows::GameOfThrones.quote,
		administrator_id: User.find(rand(User.first.id..User.last.id)).id,
		city_id: City.find(rand(City.first.id..City.last.id)).id
		)
end

n = Listing.first.id
Listing.all.length.times do
	x = 1
	y = 15
	z = 30
	5.times do
		Reservation.create!(
			start_date: Faker::Time.between_dates(from: Date.today + x, to: Date.today + rand(x + 1..y), period: :evening), 
			end_date: Faker::Time.between_dates(from: Date.today + y, to: Date.today + rand(y + 1..z), period: :morning),
			guest_id: User.find(rand(User.first.id..User.last.id)).id,
			listing_id: n
		)
		x = z + 1
		y = x + 14
		z += 30
	end
	x = 1
	y = 15
	z = 30
	5.times do
		Reservation.create!(
			start_date: Faker::Time.between_dates(from: Date.today - z, to: Date.today - rand(y..z-1), period: :evening), 
			end_date: Faker::Time.between_dates(from: Date.today - (y-1), to: Date.today - rand(x..y-2), period: :morning),
			guest_id: User.find(rand(User.first.id..User.last.id)).id,
			listing_id: n
		)
		x = z + 1
		y = x + 14
		z += 30
	end
	n += 1
end