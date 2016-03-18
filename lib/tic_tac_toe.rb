
WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5], 
  [6,7,8],
  [0,3,6], 
  [1,4,7], 
  [2,5,8], 
  [0,4,8], 
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
  !(board[position.to_i].nil? || board[position.to_i] == " ")
end

def valid_move?(board, position)
  !position_taken?(board, position.to_i-1) && (position.to_i).between?(1,9)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if !valid_move?(board, position)
    turn(board)
  else
    move(board, position, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |board_spot|
    if board_spot == "X" || board_spot == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo_set|
    if board[combo_set[0]] == "X" && board[combo_set[1]] == "X" && board[combo_set[2]] == "X"
      return combo_set
    elsif board[combo_set[0]] == "O" && board[combo_set[1]] == "O" && board[combo_set[2]] == "O"
      return combo_set
    end
  end
  false
end

def full?(board)
  board.none?{|board_space| board_space == " " }
end

def draw?(board)
  won?(board) == false && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
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


