# Helper Method

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if x.include?('X') || x.include?('O') 
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    "X"
  else
    "O"
  end
end


def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def play(board)
  i = 1
  while i <= 9
    turn(board)
    i += 1
  end
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def won?(board)
  answer = true
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1] 
    position_2 = board[win_index_2] 
    position_3 = board[win_index_3]


    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return answer = win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return answer = win_combination
    else
      answer = false
    end
  end
  answer
end



def full?(board)
  if board.any? {|space| space.include?(" ")}
    false
  else
    true
  end
end

def draw?(board)
  if full?(board)
    if won?(board)
      false
    else 
      true
    end
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == false
    nil
  else
    x = won?(board)[0]
    if board[x] == "X"
      "X"
    else
      "O"
    end
  end
end

## PLAY METHOD ##
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
