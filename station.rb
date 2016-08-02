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

	def get_quantity
		rand(0..20)
	end

	def get_price
		rand(100..500)
	end

	def initialize(station)
		@station = station
		@implants = {
			"spike": [get_quantity, get_price],
			"flex": [get_quantity, get_price],
			"rage": [get_quantity, get_price],
			"sight": [get_quantity, get_price],
			"sleep": [get_quantity, get_price],
			"swap": [get_quantity, get_price],
			"fount": [get_quantity, get_price]
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