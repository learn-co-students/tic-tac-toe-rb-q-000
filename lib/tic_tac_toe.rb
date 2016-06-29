require 'pry'
#Possible win combinations
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

#Displays the current status of the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Converts the users input into the correct index
def input_to_index(input)
  input.to_i - 1
end

#Allows the player to make a move on the board
def move(board, input_to_index, character)
  board[input_to_index] = character
end

#Determines whether or not the position is taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#Determines whether or not the move selected is valid_move
def valid_move?(board, index)
#  binding.pry
  index.between?(0,8) && !position_taken?(board, index)
end

#The logic of a single turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#Counts the number of turns taken
def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      count += 1
    end
  end
  return count
end

#Determines the current player
def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

#Determines if the game has been won
def won?(board)
  WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
        return combo unless board[combo[0]] == " "
      end
  end
  false
end

#Determines if the board is full
def full?(board)
  if board.include?(" ")
    false
  else
    true
  end
end

#Determines if the game is a draw
def draw?(board)
  if full?(board) && !won?(board)
    true
  elsif !(won?(board) && full?(board)) || won?(board)
    false
  end
end

#Determines if the game has been won, is a draw, or if the board is full
def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

#Displays the winner
def winner(board)
  if won?(board) && board[won?(board)[0]] == "X"
    "X"
  elsif won?(board) && board[won?(board)[0]] == "O"
    "O"
  else
    nil
  end
end

#Plays the game
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
