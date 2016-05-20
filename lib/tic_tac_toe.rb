board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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
  puts "-"*11
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-"*11
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, input, value)
    board[input] = value
end

def position_taken?(board, input)
  if board[input] == " "
      false
    elsif board[input] == ""
      false
    elsif board[input] == nil
      false
    else board[input] == "X" || board[input] == "O"
      true
    end
  end

  def valid_move?(board, input)
    if input.between?(0,8) && !position_taken?(board, input)
       true
    else
       false
    end
  end

  def turn(board)
    puts "Please make a move between 1 and 9"
    input = gets.strip
    input = input_to_index(input)
    if valid_move?(board, input)
      move(board, input, current_player(board))
      display_board(board)
    else turn(board)
       "Please enter valid number"
    end
end


def turn_count(board)
    move_count = 0
    while move_count < 10
      move_count += 1
    end
    return move_count
  end

def turn_count(board)
  board.count {|x| x == "X" || x == "O" }
  end

  def current_player(board)
    if turn_count(board) % 2 != 0
       return 'O'
    else turn_count(board) % 2 == 0
       return 'X'
    end
  end


  def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combo
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combo
  end
  end
  return nil
  end

  def full?(board)
      if board.all? { |cell| cell == "X" || cell == "O" }
      return true
    end
  end

  def draw?(board)
    if !won?(board) && full?(board)
      return true
    else !won?(board) && !full?(board) || !won?(board)
      return false
    end
  end

  def over?(board)
    if draw?(board) || won?(board) || full?(board)
      return true
    else
      return false
    end
  end

  def winner(board)
    if winning_combo = won?(board)
      board[winning_combo.first]
    end
  end

  def play(board)
    until over?(board)
        turn(board)
        turn_count(board)
    end
    if won?(board)
      puts "Congrats, you won!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end
