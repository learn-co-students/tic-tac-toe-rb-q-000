
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # 2nd column
  [2,5,8], # 3rd column
  [0,4,8], # Diagonal
  [2,4,6]  # Diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

def move(board,index,current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
   index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)

  if valid_move?(board,index)
    move(board,index,current_player(board))

    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  turns

end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)

    WIN_COMBINATIONS.each do |win|

    win_index_1 = win[0]
    win_index_2 = win[1]
    win_index_3 = win[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win # return the win_combination indexes that won.

      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win # return the win_combination indexes that won.
      end

    end
    return false
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  spot = won?(board)
  if spot
  index = spot[0]
  pos = board[index]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end

end
