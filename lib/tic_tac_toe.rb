# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  if over?(board)
    puts "Text"
  end
end

def move(board, location, current_player)
  location = location.to_i - 1
  board[location] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, location)
  location = location.to_i - 1
  location.between?(0,8) && !position_taken?(board, location)
end

def turn(board, player='X')
  puts "Please enter 1-9:"
  input = gets.strip
  location = input.to_i
  if valid_move?(board, location)
    move(board, location, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |spot|
    if (spot == 'X' || spot == 'O')
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turns = turn_count(board)
  if turns == 0 || turns%2 == 0
    return 'X'
  else
    return 'O'
  end
end


# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2], [0, 3, 6], [0, 4, 8], [2, 5, 8], [6, 7, 8], [1, 4, 7], [2, 4, 6], [3, 4, 5]]

def won?(board)
  if !board.include?("X") && !board.include?("O")
    return false
  end
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == 'X' || board[combo[0]] == 'O'
      if board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
        puts "Congratulations #{board[combo[0]]}!"
        return combo
      end
    end
  end
  return false
end

def full?(board)
  if board.include?(" ")
    return false
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end

def over?(board)
  if full?(board) || draw?(board) or won?(board)
    return true
  end
  return false
end

def winner(board)
  victor = won?(board)
  if victor == false
    return nil
  else return board[victor[0]]
  end
end
