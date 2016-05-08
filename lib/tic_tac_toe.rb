
WIN_COMBINATIONS=[
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2]
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move (board, location, player ="X")
  board[(location.to_i) -1 ]=player
end

def position_taken?(board, position)
  if board[position] == "" || board[position] == " " || board[position] == nil
      return false
   elsif board[position] == "X" || board[position] == "O"
      return true
  end
end

def valid_move?(board, position)
  index = position.to_i-1
  if index.between?(0,8) && !position_taken?(board, index)
    return true
   else
    return false
   end
  end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets
  if valid_move?(board, user_input)
    move(board, user_input, current_player(board))
    display_board(board)
    return true
  else
    turn(board)
  end
end

def turn_count(board)
    counter = 0
    board.each do | occupied_positions |
      if  occupied_positions == "X" ||  occupied_positions =="O"
        counter+=1
      end
    end
     counter
end

def current_player(board)
  turn_count(board)
  if turn_count(board) % 2 == 0
     return "X"
   else
     return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do | win_combination |
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 ==  position_2 && position_2 ==  position_3 && position_1 != " "
      return win_combination
    else
      false
    end
  end
end

def full?(board)
  board.none? do | position |
    position == " "
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_combination = won?(board)
  if win_combination
    win_index = win_combination[0]
    board[win_index]
  end
end


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
