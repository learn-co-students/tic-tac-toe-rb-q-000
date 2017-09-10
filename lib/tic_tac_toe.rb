def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input) #Convert input to array index
  user_input.to_i - 1
end

def move(board, index, current_player) #Move player to selected spot - X is default player
  board[index] = current_player
end

def position_taken?(board, index) #is chosen index occupied?
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index) #index on board and unoccupied?
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip #get input
  index = input_to_index(input) #normalize
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board) #if valid, place and update board
  else
    puts "Invalid input, try again."
    turn(board) #otherwise ask again
  end
end

# Define your play method below
def play(board)
  until over?(board) #unless it's over
    turn(board) #roll
  end

  if won?(board) #if someone won
    player = winner(board)
    puts "Congratulations #{player}!" #tell them
  elsif draw?(board)
    puts "Cats Game!"
  elsif !over?(board)
    play(board)
  end
end

def turn_count(board)
  turns = 0
  board.each_index do |index|
    if position_taken?(board,index) # count a turn per space filled
      turns +=1
    end
  end
  return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0 # Even is player X
    return "X"
  else
    return "O"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top
  [3,4,5], #Middle
  [6,7,8], #last
  [0,3,6], #left
  [1,4,7], #center
  [2,5,8], #right
  [0,4,8], #backslash
  [6,4,2] #forward slash
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    index_1 = win_combination[0]
    index_2 = win_combination[1]
    index_3 = win_combination[2]

    position_1 = board[index_1]
    position_2 = board[index_2]
    position_3 = board[index_3]

#if the values of the win_combination index is..
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end

def draw?(board)
  !won?(board) && full?(board)
end


def full?(board)
  board.each_index do |index|
    if !position_taken?(board,index)
       return false
    end
  end
  return true
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    win_combination = won?(board)
    if board[win_combination[0]] == "X"
      return "X"
    elsif board[win_combination[0]] == "O"
      return "O"
    end
  end
end
