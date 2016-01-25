WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal right
  [6,4,2]  # Diagonal left
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
  board[position.to_i-1] = char.upcase
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position.between?(0,8) && position_taken?(board,position) == false
    true
  else
    false
  end    
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position)
    move(board,position,current_player(board))
    display_board(board)
  else
    puts "Please enter 1-9:"
    position = gets.strip
  end
end

def turn_count(board)
  board.count{|i| i != " "}
end

def current_player(board)
  if turn_count(board) < 9 && turn_count(board) == 0 || turn_count(board) % 2 == 0
    "X"
  else
    "O" 
  end
end

def won?(board)
    i = 0
    while i < 8
      win_combination = WIN_COMBINATIONS[i]
        if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
          return WIN_COMBINATIONS[i]
        elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
          return WIN_COMBINATIONS[i]
        # else
        #   false
        end
      i += 1
    end
end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if identifier = won?(board)
    board[identifier.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
