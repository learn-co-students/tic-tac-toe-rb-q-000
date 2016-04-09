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

def display_board(board)
  #assumes 9-slot board
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, slot)
  slot.to_i.between?(1,9) and !position_taken?(board, slot.to_i-1)
end

def move(board, slot, value = "X")
  board[slot.to_i-1] = value
end

def turn(board)
  puts "Please enter 1-9:"
  slot = gets.strip
  if !valid_move?(board, slot)
    turn(board)
  end
  move(board, slot, current_player(board))
  display_board(board)
end


# Define your play method below
def play(board)
  while !over?(board) && !won?(board) && !draw?(board)
    turn(board)
  end
  puts won?(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"
end

def turn_count(board)
  counter = 0
  board.each do |move|
    if move.include? "X" or move.include? "O"
     counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def position_taken?(board, board_pointer)
  board[board_pointer] == "X" or board[board_pointer] == "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|item| item == "X" or item == "O"}
end

def draw?(board)
  full?(board) and !won?(board)
end

def over?(board)
  full?(board)
end

def winner(board)
  winning_moves = won?(board)
  winning_moves ?  board[winning_moves[0]] :nil
end