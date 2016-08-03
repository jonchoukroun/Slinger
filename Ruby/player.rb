class Player

	# Allow other classes to access Player instance variables
	attr_accessor :name
	attr_accessor :health
	attr_accessor :cash
	attr_accessor :debt
	attr_accessor :inventory
	attr_accessor :weapon

	def initialize(health = 100, cash = 2000, debt = 2000)
		@health = health
		@cash = cash
		@debt = debt

		# Player's owned neural implants:
		@inventory = {
			"spike": 0,		# Gives one free turn
			"flex": 0,		# Increase carry capacity for 5 turns
			"rage": 0,		# Increase damage by 10%
			"sight": 0,		# Preview next turn's price changes
			"sleep": 0,		# Lose 5 days
			"swap": 0,		# Decrease prices by 10%
			"fount": 0		# Regenerate health
		}

		# MVP: max capacity = 30
		@coat_max = 30

		# Holster - adding a weapon removes previous weapon
		@weapon = "None"
			# Weapons:
			# KLAW: simple club, low damage
			# 10mm: 3-shot pistol with reflex sight, medium damage
			# UTS-15: Large-magazine shotgun, high damage
	end

	def get_name
		puts "\n" * 5
		print "Please enter your name: "
		@name = gets.chomp
	end

	def change_health(amount)
		@health += amount
	end

	def change_cash(amount)
		@cash += amount
	end

	def incur_debt
		@debt *= 1.1
		@debt.round
	end

	def pay_off_debt
		@debt = 0
	end

	# Returns true if purchase will surpass carrying capacity
	def full_coat?(add)
		add + @inventory.each_value.reduce(:+) > @coat_max
	end

	def change_inventory(implant, amount)
		@inventory[implant] += amount

	end

	def display_inventory
		@inventory.each { |implant, amount|
			print "#{implant.capitalize}: #{amount}\n" if amount > 0
		}
	end

	def add_weapon(weapon)
		@weapon = weapon
	end

	def display_stats
		puts """
		#{@name}'s Statistics
		--------------------------------
		Health: #{@health}%
		Cash: $#{@cash.round}
		Debt: $#{@debt.round}
		Weapon: #{@weapon}
		Carrying space: #{@coat_max - @inventory.each_value.reduce(:+)}
		--------------------------------
		"""
	end
end

# # Create new player at game start
# new_game = Player.new
# # new_game.get_name
# # new_game.display
# new_game.change_inventory(:spike, 29)
# new_game.change_inventory(:flex, 1)