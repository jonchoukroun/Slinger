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

	def get_price(min, max)
		rand(min..max)
	end

	def initialize(station)
		@station = station
		@implants = {
			# implant: [get_quantity(q), get_price(min, max)]
			"spike": [get_quantity(45), get_price(500, 1300)],
			"flex": [get_quantity(50), get_price(300, 900)],
			"rage": [get_quantity(60), get_price(450, 1500)],
			"sight": [get_quantity(10), get_price(15000, 25000)],
			"sleep": [get_quantity(100), get_price(10, 65)],
			"swap": [get_quantity(40), get_price(1000, 3500)],
			"fount": [get_quantity(15), get_price(5000, 14000)]
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
			puts "#{implant.capitalize}: #{data[Q]} @ $#{data[P]}\n"
		}
	end
end

location = Station.new('Downtown')		# Always start in Downtown
# puts location.current_implants