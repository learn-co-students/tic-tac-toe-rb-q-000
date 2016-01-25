def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [3,4,5],
  [6,7,8],
  [6,4,2]]

def move(board, location, player = "#{current_player(board)}")
  board[location.to_i-1] = player
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
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |board|
    if "#{board}" == "X" || "#{board}" == "O" 
      counter +=1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else turn_count(board).odd?
    "O"
  end
end

def full?(board)
  if board.detect {|spot| spot == " "}
    false
  else
    true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
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

def won?(board)
  WIN_COMBINATIONS.each do |chickendinner|
    if chickendinner.all? {|index| board[index] == "X" }
      return chickendinner
    elsif chickendinner.all? {|index| board[index] == "O"}
      return chickendinner
    end
  end
  false
end

def winner(board)
  WIN_COMBINATIONS.each do |chickendinner|
    if chickendinner.all? {|index| board[index] == "X" }
      return "X"
    elsif chickendinner.all? {|index| board[index] == "O"}
      return "O"
    end
  end
  nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  winner = winner(board)
  if won?(board)
    puts "Congratulations #{winner}!"
  else draw?(board)
    puts "Cats Game!"
  end
end



