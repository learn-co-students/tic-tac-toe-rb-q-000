def play(board)
puts "Welcome to Tic Tac Toe!"
  while !over?(board)
     turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def turn(board)
  puts "Please enter 1-9:"
  location = gets
  if valid_move?(board, position)
    move(board, position)
  else
   turn(board)
  end
  display_board(board)
end



def move(board, position, current_player = "X")
  board[position.to_i-1] = current_player(board)
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !(position_taken?(board, position.to_i-1))
end


def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end


def turn_count(board)
  num_of_turns = 0
  board.each do |i|
    if i == "X"
      num_of_turns += 1
    elsif i == "O"
      num_of_turns += 1
    end
  end
  return num_of_turns
end


def current_player(board)
  turn_count(board) % 2 != 0 ? "O" : "X"
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    combo_1 = board[combo[0]]
    combo_2 = board[combo[1]]
    combo_3 = board[combo[2]]
    return combo if combo_1 == "X" && combo_2 == "X" && combo_3 == "X"
    return combo if combo_1 == "O" && combo_2 == "O" && combo_3 == "O"
  end
  false
end

def full?(board)
  board.include?(" ") ? false : true
end

def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if combo = won?(board)
    board[combo[0]]
  end
end