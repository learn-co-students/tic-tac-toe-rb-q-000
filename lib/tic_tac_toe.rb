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

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0, 1, 2],   #top row
    [3, 4, 5],   #middle row
    [6, 7, 8],   #bot row
    [0, 3, 6],   #L column
    [1, 4, 7],   #M column
    [2, 5, 8],   #R column
    [0, 4, 8],   #LD diagonal
    [6, 4, 2]    #RU diagonal
  ]

def won?(board)
  #WIN_COMBINATIONS.any? { |combo| combo.all? {|item| item == "X"} }
  winner = WIN_COMBINATIONS.detect { |combo|
    combo.all? {|item| board[item] == "X" } || combo.all? {|item| board[item] == "O" }
    }
  winner.nil? ? nil : winner
end

def full?(board)
  is_full = WIN_COMBINATIONS.all? do |combo|
    combo.all? {|item| position_taken?(board, item)}
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board).nil? ? nil : board[won?(board)[0]]
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |value|
    if value != " " && value != ""
      counter +=1
    end
  end
  counter
end

def current_player(board)
  counter = turn_count(board)
  counter % 2 == 0 ? "X" : "O"
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
