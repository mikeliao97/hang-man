require './new_game.rb'
require 'yaml'

$fileName = "savedGames.yaml"
class HangmanRunner
	attr_accessor :board
	def initialize
		# 1. get input from user for saved game
		# 2. Otherwise create a new board
		# 3. needs a method to validate input
		# 4. The board should get input		
		input = validateGameInput
		
	end

	#this method validates that the saved game chosen is one that exists
	def validateGameInput		
		continueLoop = true
	
		puts "Welcome to the best Hangman Game Ever!"
		while continueLoop			
			puts "**************************************"
			puts "1. New Game"
			puts "2. Saved Game"

			input = gets.chomp.to_i

			case input
			when 1				
				continueLoop = false
				@board = Hangman::Board.new 
				playGame
			when 2 
				continueLoop = false
				playExistingGame
			else
				puts "Invalid input! Try again!"
			end
		end
		return input
	end
	#start the game
	def playGame
		while(@board.movesLeft > 0) do
			@board.display_board #display the board which shows
			
			puts "Enter a move or 'save' to save game" #ask the user for a move
			input = cleanMove(gets.chomp) 

			@board.update_board(input) #update the board with the new board
		end
		puts "Shucks you lost"
	end

	#a cleanMOve
	def cleanMove(input)
		#use regex to make sure 
		aThroughZ = /[a-z]/

		#save the game maybe?
		if(input == 'save')
			save(@board)
		end

		badMove = true;
		while(badMove)
			if(aThroughZ.match(input).nil?)
				puts "That is a bad input. lowercase a-z only please!"							
				input = gets.chomp
			else
				puts "Good input"
				badMove = false;
			end

		end
		return input 
	end

	def save(board)
		yamlString = YAML::dump(board)
		f = File.new($fileName, "a")		
		f.puts yamlString
		f.puts ""			
		f.close
		exit
	end

	def load(board)
		
	end
 
	def playExistingGame		
		array = []
		$/="\n\n"
		File.open($fileName, "r").each do |object|
  			array << YAML::load(object)
		end
			$/="\n"
		array.each_with_index do |file, index|
			puts "#{index}. #{file}"			
		end
		puts "Please choosing an existing object"		
		input = gets.chomp.to_i
		@board = array[input]
		puts @board.display_board
		puts @board.movesLeft
		playGame
	end

end

playHangman = HangmanRunner.new

=begin
puts "Welcome to Hangman!!!!!!!!!"
		puts "---------------------------"
		puts "Would you like to play a saved game?"
		#Go over
		SavedGames.each_with_index do |index, game|			
			puts "#{index}. #{game}"
		end
		puts "Or maybe a new game perhaps?"

		#allow the users to get the game based on the number the user chooses
		input = gets.chomp.
		validateGameInput(input)	
=end