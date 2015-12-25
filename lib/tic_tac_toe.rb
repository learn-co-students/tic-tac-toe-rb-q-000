WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, location)
  if location.to_i.between?(1, 9) && !position_taken?(board, location.to_i-1)
      true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  location = gets.strip
    if !valid_move?(board, location)
      turn(board)
    end
  move(board, location, current_player(board))
  display_board(board)
end

def turn_count(board)
  i = 0
  board.each do |current_player|
    if "#{current_player}" == "X" || "#{current_player}" == "O"
      i += 1
    else
    end
  end
  i
end

def current_player(board)
  if turn_count(board) % 2 == 0
     "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find { |winning_move|
    if position_taken?(board, winning_move[0]) && board[winning_move[0]] == board[winning_move[1]] && board[winning_move[1]] == board[winning_move[2]]
       [winning_move[0], winning_move[1], winning_move[2]]
    else
    end
    }
end

def full?(board)
  board.all? { |occupied| occupied == "X" || occupied == "O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    board[winning_combo[0]]
  else
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
    else
    end
end