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

	end

	def display
		puts "Welcome to #{@current_station}"
	end

	def take_turn
		@turns -= 1
	end

	def select_location
		puts "\n" * 2
		puts "Moving..."
		puts "-" * 50
		(0...@locations.length).each { |n|
			print "#{n + 1}: #{@locations[n]}\n"
		}

		puts "Select a new location by selecting its number:"
		new_location = gets.chomp.to_i

		# Ensure selection is valid
		if new_location == 0 || new_location > 6
			puts "\n" * 10
			puts "That is not a valid selection, try again."
			move_to
		else
			@locations[new_location - 1]
		end
	end

	def see_implants_menu
	end

	def player_turn
	end


end

play = Game.new
play.move_player