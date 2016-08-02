# Stations will be identical for MVP
# Make stations differ on police/mugger presence, implant availability


# Container for all stations
@locations = [
			'Downtown',
			'Chinatown',
			'Hollywood',
			'Venice Beach',
			'Koreatown',
			'South Central'
]

class Station
	# Constant Q = Quantity
	Q = 0
	# Constant P = Price
	P = 1

	def get_quantity(max)
		rand(0..max)
	end

	def get_price(multiplier)
		rand(10..50) * multiplier
	end

	def initialize(station)
		@station = station
		@implants = {
			"spike": [get_quantity(10), get_price(500)],
			"flex": [get_quantity(50), get_price(40)],
			"rage": [get_quantity(60), get_price(100)],
			"sight": [get_quantity(6), get_price(1000)],
			"sleep": [get_quantity(100), get_price(20)],
			"swap": [get_quantity(40), get_price(65)],
			"fount": [get_quantity(10), get_price(600)]
		}
	end

	def display_station
		puts "Welcome to #{@station}.\n"		
	end

	def implants_menu
		puts "Implants available:"
		puts "-" * 50
		@implants.each { |i, n|
			puts "#{i.capitalize}: #{n[Q]} @ $#{n[P]}\n"
		}
	end
end

# Prompt player to select new location
def move_to
	puts "\n" * 2
	puts "Moving..."
	puts "-" * 50
	(0...@locations.length).each { |n|
		print "#{n + 1}: #{@locations[n]}\n"
	}

	puts "Select a new location by selecting its number:"
	new_location = gets.chomp.to_i

	# Ensure selection is valid
	if new_location == 0 || new_location > 6
		puts "\n" * 10
		puts "That is not a valid selection, try again."
		move_to
	else
		@locations[new_location - 1]
	end
end

location = Station.new('Downtown')		# Always start in Downtown
location.display_station
location.implants_menu
location = Station.new(move_to)
location.display_station
location.implants_menu