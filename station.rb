 # Stations will be identical for MVP
# Make stations differ on police/mugger presence, implant availability


class Station

	# Allow other classes to access Station instance variables
	attr_accessor :station
	attr_reader :implants

	# Constants to access implant price data array
	# Q = Quantity
	Q = 0
	# P = Price
	P = 1

	def get_quantity(max)
		rand(0..max)
	end

	def get_price(q, m, b)
		q = get_quantity(q)
		[q, (q * m + b).round]

	end

	def initialize(station)
		@station = station
		@implants = {
			# implant: [get_price(max_quantity, slope, y-intercept)]
			"spike": get_price(45, -17, 1300),		# Gives 1 free turn
			"flex": get_price(65, -9, 900),			# Increase carry capacity 20%
			"rage": get_price(50, -21, 1500),			# Increase damage 20%
			"sight": get_price(10, -1000, 25000),		# Preview price changes
			"sleep": get_price(100, -0.55, 65),		# Lose a turn
			"swap": get_price(30, -83, 3500),			# Reduce prices 10%
			"fount": get_price(20, -450, 14000)		# Restore health
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
			puts "#{implant.capitalize}: #{data[Q]} #{'.' * 5} @ $#{data[P]}\n"
		}
	end
end

location = Station.new('Downtown')		# Always start in Downtown
location.implants_menu