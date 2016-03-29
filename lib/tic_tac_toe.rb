#Constant

WIN_COMBINATIONS = [
  [0, 1, 2], #Top Row
  [3, 4, 5], #Middle Row
  [6, 7, 8], #Bottom Row

  [0, 3, 6], #Left Column
  [1, 4, 7], #Middle Column
  [2, 5, 8], #Right Column

  [0, 4, 8], #Diagonal 1
  [2, 4, 6] #Diagonal 2
]

#METHODS

#Display Board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Move
def move (board, position, value = "X")
  board[position.to_i - 1] = value
end

#Position Taken
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

#Valid Move*
def valid_move?(board, position)
  position = position.to_i
  if (position.between?(1, 9) && !position_taken?(board, position-1)) 
    return true
  end
  return false
end

#Turn
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if (valid_move?(board, position))
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#Current Player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

#Turn Counter
def turn_count(board)
  x_counter = 0
  o_counter = 0

  board.each do |token|
    if token == "X"
      x_counter += 1
    elsif token == "O"
      o_counter += 1
    else
      nil
    end
  end
 return x_counter + o_counter
end

#Won
def won?(board)
  WIN_COMBINATIONS.find do |win|
    position_taken?(board, win[0]) && win.all? { |x| board[x] == board[win[0]] }
  end
end

#Full
def full? (board)
  !board.any? do |x|
    x == " "
  end
end

#Draw
def draw? (board)
  full?(board) && !won?(board)
end

#Over
def over? (board)
  won?(board) || draw?(board) || full?(board)
end


#Winner
def winner (board)
  gold = won?(board)
  if won?(board)
    return board[gold[0]]
  else
    return nil
  end
end


#Play Method
def play(board)
  while turn_count(board) < 9 && !over?(board)
    turn(board)
  end
  if over?(board)
    if draw?(board)
      puts "Cats Game!"
    else
      puts "Congratulations #{winner(board)}!"
    end
  end
end