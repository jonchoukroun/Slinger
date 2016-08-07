# Contains all methods defining and executing random events
# MVP will not include fighting mechanism

# Call on Player class methods
require_relative 'player'

class Events
	def initialize(health, debt, inventory)
		@inventory = inventory
		@debt = debt
	end

	# Alll events return array [health, cash, [implant, amount]]

	# Probability of collector rises each time debt increase by 1000
	def collector
		probability = 0.017 * ((@debt.to_i - 2000) / 1000)
		return false unless rand(1..100) < probability * 100

		# @new_player.change_health(-30)

		system 'clear'
		puts """
		A team of GeneTech Bank collectors surrounds you as you leave the train.

		They lecture you on the importance of paying one's debts, and
		responsibility in general.
		To teach you a lesson, they pin you down while the Chief Collector cuts
		off one of your fingers with a pair of pruning shears.
		"""

		puts "Press ENTER to continue..."
		gets.chomp

		return [-30, 0, [null, 0]]

	end

	def glitcher
		return false unless rand(0..100) < 10

		@inventory.each { |implant, amount|
			@new_player.change_inventory(implant, -amount)
		}

		system 'clear'
		puts """
		A Glitcher corners you on the subway platform.

		She's too strong for you to fight, and too fast for you to run.
		Without a word she slams you into a wall and tears into your coat.
		She takes all your implants, but at least you're still alive.
		"""

		puts "Press ENTER to continue..."
		gets.chomp
	end

	def random_implant
		@inventory.keys[rand(0...@inventory.length)]
	end

	def package
		# puts "Package"
		return false unless rand(0..100) < 10

		implant = random_implant
		amount = rand(1..5)

		system 'clear'
		puts """
		You find a backpack on the seat next to you.
		
		Inside you find #{amount} #{implant} implants.
		Today must be your lucky day.
		"""

		puts "Press ENTER to continue..."
		gets.chomp
	end

	def occurence?
		collector if @debt > 0
		glitcher if @inventory.each_value.reduce(:+) > 0
		package
	end
end


test = Events.new
test.collector