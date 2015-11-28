#Helper Methods
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

def move(board, location, current_player = "X" )
      board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
position= position.to_i - 1

  if position_taken?(board, position)
  return false

  elsif position.between?(0,8)
     return true
  elsif position < 0 || position > 8
      return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    current_player = current_player(board)
    move(board,input, current_player)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  occupied_positions = 0
  board.each do |countocc|
    if countocc == "X" || countocc == "O"
      occupied_positions += 1
    end
  end
  return occupied_positions
end

def current_player(board)
      if turn_count(board).even?
        "X"
      else
        "O"
      end
end

  #puts "turn count #{turn_count(board)}"
#puts "first_player= #{firstplayer}"
#puts "turn_count even? = #{turn_count(board).even?}"
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end



def full?(board)
  board.none? do |open|
    (open == "") || (open ==" ") || (open== nil)
      end
end

def draw?(board)
  if !(won?(board))
    if full?(board)
      true
    else
      false
    end
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
  winning_combo = won?(board)
  puts" WC-- #{winning_combo}"
  if won?(board)
    if board[winning_combo[0]] == "X"
      "X"
    else
      "O"
    end
  end
end

def play(board)

  until over?(board)
    turn(board)
  end

    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
    puts "Cats Game!"
    end

end

