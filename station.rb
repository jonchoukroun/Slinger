# Stations will be identical for MVP
# Make stations differ on police/mugger presence, implant availability

class Station
	def initialize(station)
		@station = station
		@locations = [
			'Downtown',
			'Chinatown',
			'Hollywood',
			'Venice Beach',
			'Koreatown',
			'South Central'
		]
	end

	def display_station
		print "Welcome to #{@station}.\n"
	end

	# Prompt player to select new location
	def move_to
		(0...@locations.length).each { |n|
			print "#{n + 1}: #{@locations[n]}\n"
		}

		puts "Select a new location:"
		new_location = gets.chomp.downcase
		# puts new_location



	end
end

location = Station.new('Downtown')		# Always start in Downtown
location.display_station
location.move_to