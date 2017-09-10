def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index_number)
  if position_taken?(board, index_number) == false && index_number.between?(0, 8)
    return true
  else
    return false
end
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def turn(board)
 puts "Please enter 1-9:"
 input = gets.strip
 index = input_to_index(input)
 character = current_player(board)
   if valid_move?(board, index)
     move(board, index, character)
     display_board(board)
   else
     turn(board)
end
end

def turn_count(board)
  board.count { |x| x if x == "X" || x == "O" }
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X" ||
    board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
end
end


def full?(board)
  board.none?{|i| i == "" || i == " " || i == nil}
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    return true
  end
end

def over?(board)
  if draw?(board) == true || full?(board) == true || won?(board) != nil
    return true
end
end

def winner(board)
  if over?(board)
    won_row = won?(board)
    return board[won_row[0]]
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
