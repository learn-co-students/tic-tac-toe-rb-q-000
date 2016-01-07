
WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
  [0,4,8], #Diagonal 1
  [6,4,2]  #Diagonal 2
]

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
  while valid_move?(board, input) != true
    puts "Please enter 1-9:"
    input = gets.strip
  end
  character = current_player(board)
  move(board, input, character)
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
    counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    combination = combination.all? do |character|
      board[character] == "X"
      end ||
    combination.all? do |character|
      board[character] == "O"
    end
    combination == true
  end
end

def full?(board)
  board.all? do |character|
    character == "X" || character == "O"
  end
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if full?(board) == true || !!won?(board) == true || draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == nil
    nil
  else
    board[won?(board)[0]]
  end
end

def play(board)
    if !!won?(board) == true
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board) == true
      puts "Cats Game!"
    else
      while over?(board) == false
        turn(board)
        play(board)
      end
    end
end