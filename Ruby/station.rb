# Stations will be identical for MVP
# Make stations differ on police/mugger presence, implant availability


class Station

	# Allow other classes to access Station instance variables
	attr_accessor :station
	attr_reader :implants

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

	def current_implants
		@implants.reject { |implant, data| data[Q] == 0 }
	end

	def implants_menu
		puts "Implants available:"
		puts "-" * 50
		current_implants.each { |implant, data|
			puts "#{implant.capitalize}: #{data[Q]} @ $#{data[P]}\n"
		}
	end
end

# location = Station.new('Downtown')		# Always start in Downtown
# location.implants_menu