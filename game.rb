# Main ruby file for runnning game
# -------------------------------
#
# Author: Jon Choukroun
# © June 2016
# Written in Ruby 2.3.1
# -------------------------------


# Pull classes from other files
require_relative 'player'
require_relative 'station'
# require_relative 'events'

class Game
	# Constants access implants values
	Q = 0
	P = 1

	# Constant line break to puts dashes
	BREAK = "\n" + "-" * 80 + "\n"

	# Prompt user to press ENTER
	CONTINUE = "Press ENTER to continue..."

	def initialize
		@turns = 30		# Increase to 30 for full game

		# Create player
		@new_player = Player.new
		system 'clear'
		@new_player.get_name
		# @new_player.change_inventory(:spike, 20)		# Add spike for testing

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
			'Change location (end turn)',
			'Quit game'
		]

	end

	def finished?
		@turns == 0
	end

	def end_game
		system 'clear'
		puts BREAK
		puts """
		Game Over!

		After #{30 - @turns} days, you made:
			$#{(@new_player.cash - @new_player.debt).round}
		"""

		# Place holder for score saving option on UI
		puts "Save score (y/n)?"
		gets.chomp
		exit!
	end

	def take_turn
		@turns -=1 
	end

	def start_game
		puts """
		#{BREAK}
					SLINGER
		------------------------------------

		Los Angeles, not long from now...

		GeneTech Inc. invents the neural implant: an injection of nano-bots
		that supercharges human ability and improves speed, strength, and the
		senses - at an astronomical cost. 

		The gap between between rich and poor expands, as those who can afford
		implants become more than human. Poverty and crime metastisize in urban
		centers, which spiral into anarchy. 
		#{BREAK}

		#{CONTINUE}
		"""
		gets.chomp
		system 'clear'

		puts """

		#{BREAK}
		Hoping to even the field, a GeneTech engineer leaks the key technology
		behind neural implantation, creating a booming black market for
		powerful - but dangerous - street implants.

		These implants, patched together in mobile labs, often malfunction
		and kill their users - or worse. The streets of Los Angeles now crawl
		with feral hunters called glitchers, victims of broken implants who
		prey on other users, obsessed with further enhancements.
		#{BREAK}

		#{CONTINUE}
		"""
		gets.chomp
		system 'clear'

		puts """

		#{BREAK}
		As a slinger, you ride LA's subway, buying and selling black market
		implants. You have 30 days to earn, if you can survive. glitchers, other
		slingers, and GeneTech Security are hunting you.

		And don't forget to pay back your loan before GeneTech Bank decides to
		send a few collectors after you. Maybe invest in protection...

		If things get too tough, you can always take one of your implants - if 
		you think it's worth the risk.
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
			# @event = Events.new
			# @event.occurence?
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

	# Call at top of each in-game menu
	def scene_head(area)
		system 'clear'
		puts "\n"
		@current_station.display_station
		puts "\nYou have #{@turns-1} turns left."
		@new_player.display_stats
		puts "...#{area}"
		puts BREAK
	end

	def get_price_data(implant)
		@quantity = @current_station.current_implants[implant][Q]
		@price = @current_station.current_implants[implant][P]
	end

	def max_afford
		@afford = @new_player.cash / @price
		return @quantity if @afford > @quantity
		@afford
	end

	def buy(implant)
		puts "\nYou can afford #{max_afford.round} #{
			implant.capitalize} implants."

		puts "\nHow many #{implant.capitalize} do you buy?"
		amount = gets.chomp.to_i

		cost = amount * @price
		if cost > @new_player.cash
			puts "You don't have enough money."
			buy(implant)
		elsif @new_player.full_coat?(amount)
			puts "You don't have enough space to carry that many implants"
			buy(implant)
		else
			@new_player.change_inventory(implant, amount)
			@current_station.change_market(implant, -amount)
			@new_player.change_cash(-cost)

			puts """
			You bought #{amount} #{implant.capitalize} for $#{cost}

			You have $#{@new_player.cash.to_i} left.
			"""
		end

		# Return to black market
		puts CONTINUE
		gets.chomp
		black_market
	end

	def sell(implant)
		puts "\nYou have #{@new_player.inventory[implant]} #{
			implant.capitalize} to sell."

		puts "\nHow many #{implant.capitalize} do you sell?"
		amount = gets.chomp.to_i

		if amount > @new_player.inventory[implant]
			puts "You don't have enough #{implant.capitalize}."
			sell(implant)
		else
			revenue = amount * @price
			@new_player.change_inventory(implant, -amount)
			@current_station.change_market(implant, amount)
			@new_player.change_cash(revenue)

			puts """
			You sold #{amount} #{implant.capitalize} implants for $#{revenue}.

			You have #{@new_player.inventory[implant]} #{
				implant.capitalize} left.
			"""
		end

		# Return to black market
		puts CONTINUE
		gets.chomp
		black_market
	end

	def pick_implant
		puts "\nEnter the name of the implant:"
		implant = gets.chomp.downcase.to_sym

		if @current_station.current_implants.include?(implant)
			return implant
		else
			puts "\nThat is not a currently available implant."
			pick_implant
		end
	end

	def valid?(input)
		['b', 'r', 's'].include?(input)
	end

	def black_market
		scene_head("At the Black Market")

		puts "\nYou current have the following implants:"
		@new_player.display_inventory
		puts BREAK

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

		if transaction_type == 's' && @new_player.inventory[implant] > 0
			sell(implant)
		else
			puts "\nYou don't have any of that implant to sell."

			puts CONTINUE
			gets.chomp
			black_market
		end

		# # Return to menu
		# puts CONTINUE
		# gets.chomp
		# # game_menu
	end

	def loan_shark
		scene_head("At GeneTech Bank")

		if @new_player.cash >= @new_player.debt
			@new_player.change_cash(-@new_player.debt)
			@new_player.pay_off_debt
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
		scene_head("Entering the Subway Station")

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
		scene_head("Checking Current Inventory")

		puts "Implants in possession:"
		@new_player.display_inventory
		puts BREAK
		
		# Return to menu
		puts CONTINUE
		gets.chomp
		game_menu
	end

	def game_menu
		scene_head("Main Menu")
		
		puts "What do you do?"
		case make_selection(@station_choices)
		when 1 then black_market
		when 2 then loan_shark
		when 3 then display_inventory
		when 4 then change_location
		when 5 then end_game
		end			
	end


end

play = Game.new
play.start_game