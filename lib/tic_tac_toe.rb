# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
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

def draw?(board)
  full?(board) && !won?(board)
end

def full?(board)
  board.all? {|position| position == "X" || position == "O"}
end

def over?(board)
  draw?(board) || won?(board).kind_of?(Array)
end

def won?(board)
#  winning_combo = []
#  win = true
#  WIN_COMBINATIONS.each do |combo|
#    combo.all? {|position| board[position] == "X"} ? winning_combo = combo : win = false
#    combo.all? {|position| board[position] == "O"} ? winning_combo = combo : win = false
#  end
#  !winning_combo.empty? ? winning_combo : win

  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end

end

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    board[winning_combo[0]]
  else
    nil
  end
end

def move(board, position, token = "X")
  board[position.to_i - 1] = token
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  if !valid_move?(board, position)
    turn(board)
  else
    move(board, position)
    display_board(board)
  end
end

def turn_count(board)
  i = 0
  board.each {|position| position == "X" || position == "O" ? i += 1 : i}
  i
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end