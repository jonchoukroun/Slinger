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
		@turns < 0
	end

	def take_turn
		@turns -=1 
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

	def select_location
		puts "Where will you go?"
		new_location = make_selection(@locations)
		@current_station = Station.new(@locations[new_location - 1])
		take_turn
		menu
	end

	def menu
		if finished?
			puts "Game over!"
		else
			@current_station.display_station
			puts "You have #{@turns} turns left."
			puts
			puts "What will you do?"
			case make_selection(@actions)
			when 1 then puts "Black Market"
			when 2 then puts "Loan shark"
			when 3 then select_location
			end			
		end
	end


end

play = Game.new
play.menu