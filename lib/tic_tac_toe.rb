# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
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

def won?(board)
#returns the winning combination
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1 == 'X' && position_2 == 'X' && position_3 == 'X'
      return win_combo
    elsif position_1 == 'O' && position_2 == 'O' && position_3 == 'O'
      return win_combo
    end
  end
  return false
end


def full?(board)
  board.none?{|i| i == " "}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    return nil
  end
end


def display_board(board)
  sep = "-----------"
  line1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  line2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  line3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  puts line1
  puts sep
  puts line2
  puts sep
  puts line3
end

def valid_move?(board, position)
  position = position.to_i
  index = position - 1
  if position.between?(1,9)
    if position_taken?(board, index)
      return false
    else
      return true
    end
  end
end

def position_taken?(board, position)
  if board[position] == "" || board[position] == ' ' || board[position] == nil
    return false
  else
    return true
  end
end

def move(board, position, mark='X')
  position = position.to_i
  board[position-1] = mark
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
    count = 0
    board.each do |spot|
        if spot == "X" || spot == "O"
            count += 1
        end
    end
    return count
end


def current_player(board)
    plays = turn_count(board)
    return plays % 2 == 0 ? 'X' : 'O'
end

def play(board)
  9.times do
    if over?(board)
      if draw?(board)
        puts "Cats Game!"
        break
      else
        puts "Congratulations #{winner(board)}!"
        break
      end
    else
      turn(board)
    end
  end
end


