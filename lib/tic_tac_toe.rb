# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    if (board[comb[0]] == board[comb[1]] && board[comb[1]]== board[comb[2]] && board[comb[0]] != " ")
      return [comb[0], comb[1], comb[2]]
    end
  end
  return false
end

def full?(board)
  return true if (board.include?(" ") == false)
  false
end

def draw?(board)
  return false if !!won?(board)
  return true if full?(board)
end

def over?(board)
  return (draw?(board)  || full?(board) || !!won?(board) )
end

def winner(board)
  WIN_COMBINATIONS.each do |comb|
    return "X" if (board[comb[0]] == board[comb[1]] && board[comb[1]]== board[comb[2]] && board[comb[0]] == "X")
    return "O" if (board[comb[0]] == board[comb[1]] && board[comb[1]]== board[comb[2]] && board[comb[0]] == "O")
  end
  return nil
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, sym)
  board[index] = sym
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  until valid_move?(board, index)
    puts "Invalid response, Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  sym = current_player(board)
  move(board, index, sym)
  display_board(board)
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations X!" if winner(board) == "X"
    puts "Congratulations O!" if winner(board) == "O"
  else
    puts "Cats Game!"
  end
end

def turn_count(board)
  filled = board.reject { |d| d == " " }
  return filled.count
end

def current_player(board)
  return "X" if turn_count(board) == 0
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
