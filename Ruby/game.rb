# Pull classes from other files
require_relative 'player'
require_relative 'station'

class Game
	# Constant line break to puts dashes
	BREAK = "\n" + "-" * 50 + "\n"

	def initialize
		@turns = 5		# Increase to 30 for full game

		# Create player
		@new_player = Player.new
		@new_player.get_name
		@new_player.change_inventory(:spike, 20)

		# Start downtown
		@current_station = Station.new("Downtown")

		# Container for all stations
		@locations = [
			'Downtown',
			'Chinatown',
			'Hollywood',
			'Venice Beach',
			'Koreatown',
			'South Central'
		]

		# Possible player choices at the station menu
		@station_choices = [
			'Visit black market',
			'Pay off loan shark',
			'Change location',
			'View inventory'
		]

	end

	def finished?
		@turns < 0 || @new_player.health == 0
	end

	def take_turn
		@turns -=1 
	end

	def new_turn
		if finished?
			puts "Game over!"
		else
			@new_player.incur_debt
			@current_station.display_station
			puts "You have #{@turns} turns left."
			# Display player stats
			game_menu
		end
	end

	def display_stats
		puts BREAK
		puts """
		#{@new_player.name}' Statistics:
		--------------------------------
			Health: #{@new_player.health}
			Cash: $#{@new_player.cash}
			Debt: $#{@new_player.debt}
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

	def buy_implant
	end

	def sell_implant
	end

	def black_market
		puts BREAK
		@current_station.implants_menu
		puts BREAK
		game_menu
	end

	def loan_shark
		if @new_player.cash >= @new_player.debt
			@new_player.debt = 0
			@new_player.cash -= @new_player.debt
			game_menu
		else
			puts BREAK
			puts "You do not have enough cash to pay your debts."
			game_menu
		end
	end

	def change_location
		puts BREAK
		puts "Where will you go?"
		new_location = make_selection(@locations)
		@current_station = Station.new(@locations[new_location - 1])
		take_turn
		new_turn
	end

	def display_inventory
		puts BREAK
		puts "Implants in possession:"
		puts BREAK
		@new_player.display_inventory
		puts BREAK
		game_menu
	end

	def game_menu
		puts BREAK
		puts "What will you do?"
		case make_selection(@station_choices)
		when 1 then black_market
		when 2 then loan_shark
		when 3 then change_location
		when 4 then display_inventory
		end			
	end


end

play = Game.new
# play.new_turn
play.display_stats