def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" or position == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
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
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip

  if valid_move?(board, input)
    player = current_player(board)
    move(board, input, player)
  else
    turn(board)
  end
  display_board(board)
end

# Define your play method below
def play

  while over?== false
    turn
    if draw? == true
      break
    end
  end
  if draw? == true
    puts "Cats Game!"
  else
    puts "Congratulations #{@board.winner}!"
  end
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
  [6,4,2]
  ]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    else
      false
    end
  end
  return false
end

def full?(board)
  board.none?{|i| i == " " || i == nil }
end

def draw?(board)
  (won?(board) == false) && (full?(board) == true)
end

def over?(board)
  (full?(board) == true) || (won?(board) != false)
end

def winner(board)
  if won?(board)
    if board[won?(board)[0]] == "X"
      return "X"
    else board[won?(board)[0]] == "O"
      return "O"
    end
  else
    nil
  end
end