# Pull classes from other files
require_relative 'player'
require_relative 'station'

class Game
	# Constants access implants values
	Q = 0
	P = 1

	# Constant line break to puts dashes
	BREAK = "\n" + "-" * 80 + "\n"

	# Prompt user to press ENTER
	CONTINUE = "Press ENTER to continue..."

	def initialize
		@turns = 5		# Increase to 30 for full game

		# Create player
		@new_player = Player.new
		system 'clear'
		# @new_player.get_name
		# @new_player.change_inventory(:spike, 20)

		# Start downtown
		@current_station = Station.new("Downtown")

		# Container for all stations
		@locations = [
			'Downtown',
			'Chinatown',
			'Hollywood',
			'Venice Beach',
			'Koreatown',
			'South Central',
			'Return to menu'
		]

		# Possible player choices at the station menu
		@station_choices = [
			'Visit black market',
			'Pay off loan shark',
			'View inventory',
			'Change location (end turn)'
		]

	end

	def finished?
		@turns < 0
	end

	def end_game
		system 'clear'
		puts BREAK
		puts """
		Game Over!

		After 30 days, you made:
			$#{(@new_player.cash - @new_player.debt).round}
		"""

		# Place holder for score saving option on UI
		puts "Save score (y/n)?"
		gets.chomp
	end

	def take_turn
		@turns -=1 
	end

	def start_game
		puts """
		#{BREAK}
					SLINGER 2080
		------------------------------------

		Los Angeles, 2065...

		GeneTech Inc. invents the neural implant: nano-bots that supercharge
		human ability and improve speed, strength, the senses...
		... at an astronomical cost. 

		The gap between between rich and poor expands, as those who can afford
		implants become more than human. Poverty and crime surpass levels common
		in the 3rd world.
		#{BREAK}

		#{CONTINUE}
		"""
		gets.chomp
		system 'clear'

		puts """

		#{BREAK}
		A GeneTech engineer leaks the key technology behind neural implantation,
		creating a booming black market in powerful - but dangerous - implants.
		These \"NIMs\", engineered in basement labs, offer a greater variety
		of abilities, but the risk of malfunction is high... The high use of
		NIMs has turned a number of the city's desperate into feral killers
		called NIMscum.

		As a slinger, you buy and sell NIMs on LA's unforgiving streets. You
		have 30 days to earn as much as possible, but look out for other
		dealers, GeneTech security, and the NIMscum. And pay back your loan to
		GeneTech Bank before they send collectors after you.
		Maybe invest in protection...

		If things get too tough, taking NIMs can always give you an edge - but
		are they worth the risk?
		#{BREAK}
		Good luck, #{@new_player.name}
		"""
		puts CONTINUE
		gets.chomp

		# First turn, doesn't incur more debt, no possibility of dying
		# No random events
		game_menu
	end

	def new_turn
		if finished?
			end_game
		else
			@new_player.incur_debt
			game_menu
		end
	end

	def display_stats
		puts BREAK
		puts """
		#{@new_player.name}'s Statistics:
		--------------------------------
			Health: #{@new_player.health}%
			Cash: $#{@new_player.cash}
			Debt: $#{@new_player.debt.round}
		--------------------------------
		Turns left: #{@turns}
		"""
		puts BREAK
	end

	def make_selection(options)
		puts "Select a number from the following menu options:"
		(0...options.length).each { |n|
			print "#{n + 1}: #{options[n]}\n"
		}
		choice = gets.chomp.to_i

		# Validate player selection
		if choice.between?(1, options.length)
			choice
		else
			puts "That is not a valid selection. Make sure to enter an integer."
			make_selection(options)
		end
	end

	# Call at top of each in-game menu
	def scene_head
		system 'clear'
		@current_station.display_station
		display_stats
		puts BREAK
	end

	def get_price_data(implant)
		@price = @current_station.implants[implant][P]
		@quantity = @current_station.implants[implant][Q]
		puts "$#{@price}, #{@quantity}"
	end

	def max_afford
		@afford = @new_player.cash / @price
		return @quantity if @afford > @quantity
		@afford
	end

	def buy(implant)
		puts "\nYou can afford #{max_afford} #{implant.capitalize} implants."

		puts "\nHow many #{implant.capitalize} do you buy?"
		amount = gets.chomp.to_i

		cost = amount * @price
		buy(implant) if cost > @new_player.cash

		@new_player.cash -= cost
		@new_player.inventory[implant] += amount

		puts """
		You bought #{amount} #{implant.capitalize} for $#{cost}

		You have $#{@new_player.cash} left.
		"""
		# Return to menu
		puts CONTINUE
		gets.chomp
		game_menu
	end

	def pick_implant
		puts "\nEnter the name of the implant:"
		implant = gets.chomp.downcase.to_sym
		pick_implant unless @current_station.implants.include?(implant)
		return implant
	end

	def valid?(input)
		['b', 'r', 's'].include?(input)
	end

	def black_market
		scene_head

		@current_station.implants_menu

		# Buy or sell method?
		puts "Would you like to (b)uy or (s)ell implants?"
		puts "Or (r) to return to menu..."
		transaction_type = gets.chomp.downcase[0]
		black_market unless valid?(transaction_type)

		game_menu if transaction_type == 'r'
		
		implant = pick_implant
		get_price_data(implant)

		buy(implant) if transaction_type == 'b'

		sell(impant) if transaction_type == 's'

		# Return to menu
		puts CONTINUE
		gets.chomp
		# game_menu
	end

	def loan_shark
		scene_head

		if @new_player.cash >= @new_player.debt
			@new_player.cash -= @new_player.debt
			@new_player.debt = 0
			puts """
			Your debt is paid and you are safe from GeneTech Bank collectors.
			"""

			# Return to menu
			puts CONTINUE
			gets.chomp
			game_menu
		else
			puts "You do not have enough cash to pay your debts."
			
			# Return to menu
			puts CONTINUE
			gets.chomp
			game_menu
		end
	end

	def change_location
		scene_head

		puts BREAK
		puts "Where will you go?"
		new_location = make_selection(@locations)
		if new_location == 7
			game_menu
		else
			@current_station = Station.new(@locations[new_location - 1])
			take_turn
			new_turn
		end
	end

	def display_inventory
		scene_head

		puts "Implants in possession:"
		@new_player.display_inventory
		puts BREAK
		
		# Return to menu
		puts CONTINUE
		gets.chomp
		game_menu
	end

	def game_menu
		scene_head
		
		puts "What do you do?"
		case make_selection(@station_choices)
		when 1 then black_market
		when 2 then loan_shark
		when 3 then display_inventory
		when 4 then change_location
		end			
	end


end

play = Game.new
play.start_game
# play.black_market
# play.get_price_data('flex')
# play.buy_implant(:rage, 3)