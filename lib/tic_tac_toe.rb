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

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,input,character = "X")
  input = input.to_i
  board[input-1] = character
end

def position_taken? (board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position) == true
    input = current_player(board)
    move(board,position,input)
    display_board(board)
  else
    puts "Invalid move"
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |counter|
    if counter == "X" || counter == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |array|
    array.all? {|input| board[input] == "X"} || array.all? {|input| board[input] == "O"}
  end
end

def full?(board)
  if board.any? {|input| input == " "}
    false
else
  true
end
end

def draw?(board)
  unless won?(board) || full?(board) ==  false
    return true
  end
end

def over?(board)
  if full?(board) == false
    return false
  else
    return true
  end
end

def winner(board)
  if won?(board)
    if WIN_COMBINATIONS.detect {|array| array.all? {|input| board[input] == "X" }}
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
until over?(board) || won?(board) || draw?(board)
turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
puts "Cats Game!"
end
end