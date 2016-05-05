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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def update_array_at_with(array, position, value)
  array[position] = value
end

def move(board, location, character)
  board[(location.to_i)-1] = character
  update_array_at_with(board,(location.to_i)-1,character)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board,position)
  position = position.to_i
  if position.between?(1,9) && position_taken?(board,(position-1)) == false
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets
  if valid_move?(board,position) && turn_count(board)%2 == 0
    move(board,position,token="X")
    display_board(board)
  elsif valid_move?(board,position) && turn_count(board)%2 != 0
    move(board,position,token="O")
    display_board(board)
  elsif
    !valid_move?(board,position)
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |location|
    if "#{location}" == "X" || "#{location}" == "O"
      counter += 1
    end
  end
  return counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.find do |win_combination|
    position_taken?(board, win_combination[0]) &&
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]]
  end
end


def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end


def draw?(board)
   !won?(board) && full?(board)
end


def over?(board)
  won?(board) || full?(board) || draw?(board)
end


def winner(board)
  if !won?(board)
    return nil
  elsif won?(board) && !draw?(board)
    return board[won?(board)[0]]
  end
end


def play(board)
  until over?(board) do
    turn(board)
  end
  over?(board) && won?(board)
    puts "Congratulations #{winner(board)}!"
  over?(board) && draw?(board)
    puts "Cats Game!"
 end
