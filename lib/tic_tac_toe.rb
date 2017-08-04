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

board = [" ", " ", " ", " ", " ", " ", " ", " ", "X"]
def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} \n"
print "-----------\n"
puts " #{board[3]} | #{board[4]} | #{board[5]} \n"
print "-----------\n"
print " #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(user_input)
  input = user_input.to_i
  index = input - 1
end

def update_array_at_with(array, index, value)
  array[index] = value
end
def move(board, index, char)
update_array_at_with(board, index, char)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  def position_taken?(board, index)
    if board[index] == " "
      false
    elsif board[index] == ""
      false
    elsif board[index] == nil
      false
    else board[index] == "X" || board[index] == "O"
      true
    end
  end

if position_taken?(board, index) == false && index.between?(0, 8) == true
  true
else position_taken?(board, index) == true && index.between?(0, 8) == false
  false
end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == true
  char = current_player(board)
  move(board, index, char)
  display_board(board)
  else valid_move?(board, index) == false
    turn(board)
end
end

def turn_count(board)
  counter = 0
  board.each do |space|
     if "#{space}" == "X" || "#{space}" == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else turn_count(board) % 2 == 1
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combinations|
    if ((board[win_combinations[0]] == "X" && board[win_combinations[1]] == "X" && board[win_combinations[2]] == "X"))
      return win_combinations
    elsif
      ((board[win_combinations[0]] == "O" && board[win_combinations[1]] == "O" && board[win_combinations[2]] == "O"))
      return win_combinations
end
end
else false
end

def full?(board)
  board.none?{|index| index == " "}
  end

  def draw?(board)
    full?(board)
    if won?(board) != false
      false
    elsif full?(board) == true
      true
    end
  end

  def over?(board)
    if draw?(board) == true
      true
    elsif won?(board) != false
      true
    elsif draw?(board) == false
      false
    end
  end

  def winner(board)
    WIN_COMBINATIONS.each do |win_combinations|
      if ((board[win_combinations[0]] == "X" && board[win_combinations[1]] == "X" && board[win_combinations[2]] == "X"))
        return "X"
      elsif
        ((board[win_combinations[0]] == "O" && board[win_combinations[1]] == "O" && board[win_combinations[2]] == "O"))
        return "O"
  end
  end
else nil
  end

  def play(board)
    until over?(board) == true
      char = current_player(board)
      turn(board)
    end
      if draw?(board) == true
        puts "Cats Game!"
      elsif won?(board) != false
        puts "Congratulations #{winner(board)}!"
      end
  end
