# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
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
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def won?(board)
  result = false
  WIN_COMBINATIONS.each do |win_combination|
    if !result
      if win_combination.all?{|i| board[i]=="X"} || win_combination.all?{|i| board[i]=="O"}
        result = win_combination
      end
    end
  end
  result
end

def full?(board)
  board.all?{|i| (i=="X"||i=="O")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winning_indices = won?(board)
  if winning_indices
    board[winning_indices[0]]
  else
    nil
  end
end

def move(board,pos,piece)
  board[pos-1]=piece
end

def valid_move?(board, pos)
  i = pos.to_i
  !position_taken?(board,i-1) && i.to_i.between?(1,9)
end

def turn(board)
  puts "Player #{current_player(board)}: please enter 1-9:"
  input = gets.strip.to_i
  while !valid_move?(board, input) do
    puts "Invalid entry, please try again."
    input = gets.strip.to_i
  end
  move(board,input,current_player(board))
  display_board(board)
end

def turn_count(board)
  board.select{|i| i=="X" || i=="O"}.length
end

def current_player(board)
  if turn_count(board)%2 == 0 
    "X"
  else
    "O"
  end
end

def play(board)
  while !over?(board) 
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end