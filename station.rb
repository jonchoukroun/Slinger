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
	def initialize(station)
		@station = station
	end

	def display_station
		print "Welcome to #{@station}.\n"
	end

end

# Prompt player to select new location
def move_to
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
location = Station.new(move_to)
location.display_station