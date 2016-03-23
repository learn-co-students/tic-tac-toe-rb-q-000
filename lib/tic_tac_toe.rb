def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

display_board(board)
display_board(board)
display_board(board)

#Define your Move
def move(board, position, player = "X")
  board[position.to_i-1] = player
end

#Define a valid move
def valid_move?(board, position)
  if position_taken?(board, (position.to_i - 1)) == true || position.to_i.between?(1, 9) == false
    return nil
  else
    return true
  end
end

#Define a position taken method
def position_taken?(board, position)
  if  board[position] == "X" || board[position] == "O" || board[position] == "x" || board[position] == "o"
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  character = current_player(board)
 if valid_move?(board, input) == true
      move(board, input.to_i, character)
      display_board(board)
    else
      turn(board)
 end
end


def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
    end
    return false
  end


  def full?(board)
      return board.all?{|element| element == "X" || element == "O"}
  end

def draw?(board)
  board.each do |piece|
    if won?(board) == false && full?(board) == true
      return true
   else
       return false
   end
  end
end

def over?(board)
    if draw?(board) == true || full?(board) == true
        return true
    else
        return false
    end
  end


def winner(board)
  if won?(board)
  winning_combination = won?(board) #[6,7,8]
  winning_position = winning_combination[0] #6
  board[winning_position] #0
end
end



WIN_COMBINATIONS = [
  [0,1,2], #Top Row
  [3,4,5], #Middle Row
  [6,7,8], #Bottom Row
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
  [0,4,8], #L-R Diagonal
  [2,4,6], #R-L Diagonal
]


def play(board)
  while over?(board) == false &&  won?(board) == false
     turn(board)
  end
  if (won?(board) == false) != true
     puts "Congratulations #{winner(board)}!"
  else
     puts "Cats Game!"
  end
end
