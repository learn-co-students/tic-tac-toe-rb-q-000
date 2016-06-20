# -- CONSTANTS -------------------------------------------------
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

# -- HELPER METHODS --------------------------------------------
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  turn_count = 0
  while turn_count < 9
    #Check for Coditions that end the Game
    if over?(board) && !draw?(board)
      puts "Congratulations #{winner(board)}!"
      break
    elsif over?(board) && draw?(board)
      puts "Cats Game!"
      break
    end

    turn(board)
    turn_count += 1
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  turns = 0

  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def move(board, index, player)
  board[index] = player
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = input_to_index(gets.strip)

  if valid_move?(board,user_input)
    move(board,user_input,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  if !board.include?("X") && !board.include?("O")
    return false
  end

  WIN_COMBINATIONS.each do |winning_line|
    if board[winning_line.first] != " " && (board[winning_line[0]] == board[winning_line[1]]) && (board[winning_line[1]] == board[winning_line[2]])
      return winning_line.to_a
    end
  end

  return false
end

def full?(board)
  return !board.include?(" ")     # If board has at least one ' ', it is not full
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if draw?(board) || full?(board)
    return true
  elsif won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if winning_line = won?(board)
    board[winning_line.first]
  end
end
