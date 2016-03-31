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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  board[position - 1] = character
  return board
end

def position_taken?(board, location)
  !(board[location.to_i].nil? || board[location.to_i] == " ")
end

def valid_move?(board, position)
  position = position.to_i - 1
  if !position_taken?(board, position) && position.between?(0, 8)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  position = input.to_i
  if valid_move?(board, position) == true
    turn_count(board)
    move(board, position, current_player(board))
   else
    until valid_move?(board, position) == true
      puts "Please enter a valid number"
      puts "Please enter 1-9:"
      input = gets.strip
      position = input.to_i
      valid_move?(board, position)
    end
    move(board, position)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
    counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
    else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    array = []
    combo.each do |element|
      if position_taken?(board, element)
        array << board[element]
      end
    end
    if array == ["X", "X", "X"] || array == ["O", "O", "O"]
        return combo
    end
  end
  false
end

def full?(board)
  board.all? do |position|
    position != " "
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) != false
    win_combo = won?(board)
    winner = ""
    winner = board[win_combo[0]]
    return winner
  end
end
##################################
def play(board)
  puts = "Welcome to Tic Tac Toe!"
  until over?(board) #until the game is over
    turn(board) #take turns
  end

   if won?(board)#if the game was won
       puts "Congratulations #{winner(board)}!"#  congratulate the winner
     elsif draw?(board)#else if the game was a draw
       puts "Cats Game!"#  tell the players it has been a draw
   end
end
#rspec spec/02_play_spec.rb