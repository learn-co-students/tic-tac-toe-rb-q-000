def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, position, char = "X")
  position = position.to_i - 1
  char = current_player(board)
  board[position] = char
end


def valid_move?(board, position)
  if position.to_i < 1 || position.to_i > 9
    false
  else
    !(position_taken?(board, position.to_i-1))
  end
end


def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    true
  else
    false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip

  if valid_move?(board,position) == true
    move(board, position)
  else
    turn(board)
  end

  display_board(board)
end


def turn_count(board)
  counter = 0
  board.each do |slot|
    if slot != " "
      counter += 1
    end
  end
  counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
      "X"
  elsif turn_count(board) % 2 == 1
      "O"
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


WIN_COMBINATIONS =[
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]]

def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
        if (board[win_combo[0]] == 'X' && board[win_combo[1]] == 'X' && board[win_combo[2]] == 'X') || (board[win_combo[0]] == 'O' && board[win_combo[1]] == 'O' && board[win_combo[2]] == 'O')
            return win_combo
        end
    end
    nil
end


def full?(board)
    !board.any? do |pos|
        pos == " "
    end
end


def draw?(board)
    full?(board) && !won?(board)
end


def over?(board)
    won?(board) || draw?(board)
end


def winner(board)
    win_combo = won?(board)
    if win_combo
        board[win_combo[0]] # == 'X' || 'O'
    else
        nil
    end
end