require 'pry'

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

def move(board, position, value="X")
  board[position.to_i-1] = value
end

def position_taken?(board, position)
  !(board[position] == " ") ? true : false
end

def valid_move?(board, position)
  position = position.to_i
  position.between?(1,9) && position_taken?(board, position-1) == false ? true : false
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  until valid_move?(board, position)
    puts "Please enter 1-9:"
    position = gets.strip
    puts "Please try entering a number again:"
  end
  move(board, position, value=current_player(board))
  display_board(board)
end

def turn_count(board)
  new_b = []
  board.select do |x|
    x != " " ? new_b << x : (nil)
  end
  return new_b.count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? (return "X") : (return "O")
end

def won?(board)
  board.none? ? false : nil
  WIN_COMBINATIONS.each do |x|
    if position_taken?(board, x[0]) && position_taken?(board, x[1]) && position_taken?(board, x[2])
      if (board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X") || (board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O")
        return x
      end
    end
  end
  return false
end

def full?(board)
  not board.include?(" ")
end

def draw?(board)
  (full?(board)) && (not won?(board))
end

def over?(board)
  (draw?(board) || won?(board)) || (full?(board))
end

def winner(board)
  if won?(board)
    won?(board).select do |x|
      board[x] == "X" ? (return "X") : (return "O")
    end
  end
end

def play(board)

  until over?(board)
    turn(board)
  end
  if won?(board)
    winner(board) == "X" ? (puts "Congratulations X!") : (puts "Congratulations O!")
  elsif draw?(board)
    puts "Cats Game!"
  end
end


