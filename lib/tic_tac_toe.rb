# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]

  def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        @position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]

        if @position_1 == "X" && position_2 == "X" && position_3 == "X"
          return win_combination
        elsif @position_1 == "O" && position_2 == "O" && position_3 == "O"
          return win_combination
        end
    end
    false
  end

  def full?(board)
    !board.include?(" ")
  end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else 
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else 
    return false
  end
end

def winner(board)
  if won?(board)
    return @position_1
  end
end

def turn_count(board)
  counter = 0
  turn = 0
  board.each do |moves|
    if board[turn] != " "
      counter +=1
    end
    turn+=1
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ?  "X" :  "O"
end

# Helper Methods
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
  board[location] != " " && board[location] != "" && board[location] != nil
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  if valid_move?(board, @input) 
     if current_player(board) == "X"
        current_player = "X"
    else
    current_player = "O"
  end
    move(board, @input, current_player)
  else
    puts "Please enter 1-9"
    @input = gets. strip
    turn(board)
  end
  display_board(board)
end

# Define your play method below
def play(board)
  counter = 0
  while over?(board) == false do
    puts "Please enter 1-9:"
    @input = gets.strip
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{@position_1}!"
  end
    
end




