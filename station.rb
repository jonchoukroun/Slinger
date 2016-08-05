 # Stations will be identical for MVP
# Make stations differ on police/mugger presence, implant availability


class Station

	# Allow other classes to access Station instance variables
	attr_accessor :station
	attr_reader :implants

	# Constants to access implant data array
	# Q = Quantity
	Q = 0
	# M = Slope
	M = 1
	# B = Y-Intercept
	B = 2

	# y = mx + b

	def get_slope(q, min, max)

	end

	def get_quantity(max)
		rand(0..max)
	end

	def get_price(q, m, b)
		q * m + b
	end

	def initialize(station)
		@station = station
		@implants = {
			# implant: [max_quantity, slope, y-intercept]
			"spike": [get_quantity(45), -17, 1300],		# Gives 1 free turn
			"flex": [get_quantity(65), -9, 900],			# Increase carry capacity 20%
			"rage": [get_quantity(50), -21, 1500],		# Increase damage 20%
			"sight": [get_quantity(10), -1000, 25000],	# Preview price changes
			"sleep": [get_quantity(100), -0.55, 65],		# Lose a turn
			"swap": [get_quantity(30), -83, 3500],		# Reduce prices 10%
			"fount": [get_quantity(20), -450, 14000]		# Restore health
		}

	end

	def display_station
		puts "Welcome to #{@station}.\n"		
	end

	def current_implants
		@implants.reject { |implant, data| data[Q] == 0 }
	end

	def change_market(implant, amount)
		@implants[implant][Q] += amount
	end

	def implants_menu
		puts "Implants available:"
		puts "-" * 50
		current_implants.each { |implant, data|
			price = get_price(data[Q], data[M], data[B])
			puts "#{implant.capitalize}: #{data[Q]} @ $#{price.round}\n"
		}
	end
end

location = Station.new('Downtown')		# Always start in Downtown
location.implants_menu