# Contains all methods defining and executing random events
# MVP will not include fighting mechanism

# Call on Player class methods
require_relative 'player'

class Events
	def initialize
		@new_player = Player.new 			# Remove after testing class
		# @debt = @new_player.debt
		@inventory = @new_player.inventory

	end

	# Generate debt for testing
	def debt
		p = 2000
		r = 1.1
		n = 29

		n.times { |n| collector(p *= r) }
	end

	# Probability of collector rises each time debt increase by 1000
	def collector(debt)
		probability = 0.017
		probability * ((debt.to_i - 2000) / 1000)
	end

	def glitcher
		# puts "Glitcher"
	end

	def package
		puts "Package"
	end

	def occurence?
		collector if @debt > 0
		glitcher if @inventory.each_value.reduce(:+) > 0
		package
	end

end


test = Events.new
# puts test.occurence?
test.debt