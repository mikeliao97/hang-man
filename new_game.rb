module Hangman	
	#this is the board that is can be displayed
	class Board
		attr_accessor :chosenWord, :wordArray, :movesLeft, :wordsGuessed
		def initialize
			@chosenWord = getWord.downcase #chosenWord has the chosen word in array
			@wordsGuessed = Array.new
			initialize_board
			@movesLeft = @chosenWord.length * 2
		end		

		def getWord
			list_of_words = "5desk.txt"
			wordFile = File.open(list_of_words, "r")
			contents = wordFile.read.split("\r\n")
			#only keep words 5 to 12 lettteres
			contents = contents.find_all {|word| word.length >= 5 && word.length <= 12 }

			#now theres a bunch of words into contents array
			#get the new word
			contents[Random.rand(contents.count)]	#return this array		
		end

		def initialize_board
			@wordArray = Array.new
			for i in 0..@chosenWord.length - 1				
				 @wordArray << " _ "
			end
		end

		def display_board
			puts "The actual word: #{@chosenWord}"
			puts "Moves Left: #{@movesLeft}"
			puts "Words Guessed: #{@wordsGuessed}"
			print wordArray
			puts ""
		end

		def update_board(input)
			if(@chosenWord.include?(input))
				puts "Good Job! You got one of the characters"
				revealWords(input)

				#there is no more underlines so the user won
				if @wordArray.include?(" _ ") == false
					puts "Congratulations You won dude!"
					@movesLeft == 0
					exit
				end
			else
				puts "Sorry you didn't get anything"				
				unless @wordsGuessed.include? input
					@wordsGuessed << input
				end
			end
			@movesLeft -= 1

		end

		private

		def revealWords(input)
			@chosenWord.split("").each_with_index do |word, index|
				if(word == input)
					@wordArray[index] = word
				end
			end

		end

	end

end