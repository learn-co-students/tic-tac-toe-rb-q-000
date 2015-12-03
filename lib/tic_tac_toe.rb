WIN_COMBINATIONS = [
  [0,1,2], #0
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [6,4,2],
  [0,4,8]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def won?(board)
  win_combination ||= nil
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return win_combination
end


def move(board, location, token = "X")
  board[location.to_i - 1] = token
end


def valid_move?(board, input)
  input.to_i.between?(1,9) && !position_taken?(board, input.to_i - 1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
end


def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if  token == "X" || token == "O"
      counter += 1
    end
  end
  counter
end



def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def full?(board)
  if board.detect { |i| i == " " }
    false
  else
    board.none?{|i| i == " "}
  end
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  elsif full?(board) == false
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
def winner(board)
  winning = won?(board)
  winning ? board[winning[0]] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end









