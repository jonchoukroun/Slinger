# Pull classes from other files
require_relative 'player'
require_relative 'station'

class Game
	def initialize
		@turns = 5		# Increase to 30 for full game

		# Create player
		@new_player = Player.new
		@new_player.get_name

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

		# Possible player actions
		@actions = [
			'Visit black market',
			'Pay off loan shark',
			'Change location'
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
			game_menu
		end
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
		puts "\n"
		@current_station.implants_menu
	end

	def loan_shark
		if @new_player.cash >= @new_player.debt
			@new_player.debt = 0
			@new_player.cash -= @new_player.debt
		else
			puts "You do not have enough cash to pay your debts."
		end
	end

	def change_location
		puts "Where will you go?"
		new_location = make_selection(@locations)
		@current_station = Station.new(@locations[new_location - 1])
		take_turn
		new_turn
	end

	def game_menu
		puts "What will you do?"
		case make_selection(@actions)
		when 1 then black_market
		when 2 then loan_shark
		when 3 then change_location
		end			
	end


end

play = Game.new
play.new_turn