class Player
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

		# Holster - adding a weapon removes previous weapon
		@weapon = ""
			# Weapons:
			# KLAW: simple club, low damage
			# 10mm: 3-shot pistol with reflex sight, medium damage
			# UTS-15: Large-magazine shotgun, high damage
	end

	def get_name
		print "Enter your name: "
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

	def change_inventory(item, amount)
		@inventory[item] += amount
	end

	def display_inventory
		@inventory.each { |item, amount|
			print "#{item.capitalize}: #{amount}\n" if amount > 0
		}
	end

	def add_weapon(weapon)
		@weapon = weapon
	end

	def display
		puts "Name: #{@name}"
		puts "Health: #{@health}%"
		puts "Cash: $#{@cash}"
		puts "Debt: $#{@debt.round}"
		puts "Weapon: #{@weapon.upcase}" unless @weapon == ''
		puts
	end
end

# Create new player at game start
new_game = Player.new
# new_game.get_name
# new_game.display