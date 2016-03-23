def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

display_board(board)
display_board(board)
display_board(board)

#Define your Move
def move(board, position, player = "X")
  board[position.to_i-1] = player
end

#Define a valid move
def valid_move?(board, position)
position.to_i.between?(1,9) && position_taken?(board, position.to_i)
end

#Define a position taken method
def position_taken?(board, position)
  if board[position.to_i-1] == " " || board[position.to_i-1] == ""
    return true
  else board[position-1] == "X" || board[position-1] == "O"
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  def turn(board)
    position = gets.strip
    if valid_move?(board, position)
      puts move(board, position, player = 'X')
      puts display_board(board)
    else
      puts "Please enter 1-9:"
      position = gets.strip
      valid_move?(board, position)
      puts move(board, position, player = 'X')
      puts display_board(board)
    end
  end
end


def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
    end
    return false
  end


def full?(board)
  board.each do |piece|
    if piece == " "
      return false
    end
  end
  return true
end

def draw?(board)
  board.each do |piece|
    if won?(board) == false
      return true
    end
  end
  return false
end

def over?(board)
  board.each do |piece|
    if full?(board) == true
      return true
    end
  end
  return false
end

def winner(board)
  if won?(board)
  winning_combination = won?(board) #[6,7,8]
  winning_position = winning_combination[0] #6
  board[winning_position] #0
end
end



WIN_COMBINATIONS = [
  [0,1,2], #Top Row
  [3,4,5], #Middle Row
  [6,7,8], #Bottom Row
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
  [0,4,8], #L-R Diagonal
  [2,4,6], #R-L Diagonal
]


def play(board)
  inputs = gets
  over?()
end
