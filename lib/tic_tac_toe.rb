WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]
]


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


def display_board(board)
  puts [" #{board[0]} ""|"" #{board[1]} ""|"" #{board[2]} "]
  puts "-----------"
  puts [" #{board[3]} ""|"" #{board[4]} ""|"" #{board[5]} "]
  puts "-----------"
  puts [" #{board[6]} ""|"" #{board[7]} ""|"" #{board[8]} "]
end


def move(board, position, xo = "X")
  board["#{position}".to_i - 1] = xo
end


def valid_move?(board, position)
  if position.to_i.between?(1, 9) && !position_taken?(board, position.to_i-1)
    true
  else
    false
  end
end



def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
    true
  end

end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
  counter = 0
  board.each do |count|
    if "#{count}" != " "
      counter += 1
    end
  end
  counter
end


def current_player(board)
  if turn_count(board) % 2 != 0
    "O"
  elsif turn_count(board) % 2 == 0
    "X"
  end
end


def won?(board)
    WIN_COMBINATIONS.detect do |win|
    board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]] &&
    position_taken?(board, win[0])
    end
end

def full?(board)
  board.all? do |token| token == "X" || token == "O"
  end
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

  def winner(board)
    if w_combo = won?(board)
      board[w_combo.first]
    end
  end




