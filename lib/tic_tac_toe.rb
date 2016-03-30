WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  position = (position.to_i-1)
  board[position] = character
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  if valid_move?(board, input)
    move(board, input,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      count+= 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
end

def won?(board)
WIN_COMBINATIONS.each do |combo|
  return combo if combo.all? {|input| board[input] == "X" }
  return combo if combo.all? {|input| board[input] == "O" }
end
  false
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
    full?(board) || draw?(board) || won?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |combo|
  return "X" if combo.all? {|input| board[input] == "X" }
  return "O" if combo.all? {|input| board[input] == "O" }
end
  return nil
end

def play(board)
    until over?(board) do
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
end