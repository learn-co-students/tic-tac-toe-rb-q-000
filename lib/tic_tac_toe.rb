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

def move (board, location, player_character = "X")
  board[location.to_i-1] = player_character
end

def position_taken?(board, position)
  if board[position.to_i] == " " || board[position.to_i] == "" || board[position.to_i] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1, 9) && !position_taken?(board, position.to_i-1)
   true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
    return position
  else 
      position.to_i.between?(1,9) ==true
      turn(board) 
  end
end

def turn_count(board)
  count = 0
    board.each do |position|
    if "#{position}" == "X" || "#{position}" == "O"
    count += 1 
    end
  end
  return count
  end


def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else 
    "O" 
  end 
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") ||
       (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
      return win_combo
      end
    end
    nil
end

def full?(board)
  !board.detect do |pos|
    pos == " "
  end 
end

  def draw?(board)
    if won?(board) || !full?(board)
      false
    else
      true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end


def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
    if won?(board)
      winner(board)
        puts "Congratulations #{winner(board)}!"
    else draw?(board)
      puts "Cats Game!"
    end
end

