board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 4, 8],
[2, 4, 6],
[0, 3, 6],
[2, 5, 8],
[1, 4, 7]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, number, player = "X")
  board[number.to_i-1] = player
end

def position_taken?(board, position)
  board[position] != " " && board[position] != "" && board[position] != nil
end



def valid_move?(board, position)
  !position_taken?(board, position.to_i-1) && position.to_i.between?(1,9)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if "#{position}" == "X" || "#{position}" == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == board[combination[1]] && 
    board[combination[1]] == board[combination[2]] && 
    position_taken?(board, combination[0])
  end
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  won?(board) || draw?(board) ? true : false
end

def winner(board)
  WIN_COMBINATIONS.detect do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && 
    board[combination[1]] == "X" && board[combination[2]] == "X"
      return "X"
    elsif board[combination[0]] == "O" && board[combination[1]] == "O" && 
    board[combination[1]] == "O" && board[combination[2]] == "O"
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  end
end
