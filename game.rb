# Pull classes from other files
require_relative 'player'
require_relative 'station'

class Game
	def initialize
		@turns = 5

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

	def take_turn
		@turns -= 1
	end

	def make_selection(options)
		puts "Select a number from the following menu options:"
		(0...options.length).each { |n|
			print "#{n + 1}: #{options[n]}\n"
		}
		choice = gets.chomp.to_i

		# Validate player selection
		if selection.between?(1..range.length)
			choice
		else
			puts "That is not a valid selection. Make sure to enter an integer."
			make_selection(options)
	end

	def select_location
		puts "Where will you go?"
		new_location = make_selection(@locations)
	end

	def menu
		@current_station.display_station
		puts "You have #{@turns} turns left."
		puts
		puts "What will you do?"
		action = make_selection(@actions)
	end


end

play = Game.new
play.menu