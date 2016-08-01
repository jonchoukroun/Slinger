class Player
	def initialize(health = 100, cash = 2000, debt = 2000)
		@health = health
		@cash = cash
		@debt = debt
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

	def display
		puts "Name: #{@name}"
		puts "Health: #{@health}"
		puts "Cash: #{@cash}"
		puts "Debt: #{@debt.round}"
		puts
	end
end

new_game = Player.new
new_game.get_name