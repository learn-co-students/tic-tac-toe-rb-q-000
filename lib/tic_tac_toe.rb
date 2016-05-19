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

def input_to_index(board)
  input = gets.to_i - 1
end

def move(board, input, value)

    board[input - 1] = value
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
    if input.to_i.between?(1,9) && !position_taken?(board, input)
       true
    else
       false
    end
  end

def turn
  input = 0
  while input < 10
    puts "Please make a move between 1 and 9"
    input = gets.chomp.to_i - 1
    if valid_move?(board, input)
      move(board, input, value)
      display_board(board)
    else
      "Please enter valid number"
    end
  end
end

def turn_count(board)
    move = 0
    while move < 9
      move += 1
    end
    return move
  end

  def current_player(board)
    if turn_count(board) % 2 != 0
      'O'
    else turn_count(board) % 2 == 0
      'X'
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
      turn
      turn_count(board)
    end
    if won?(board)
      puts "Congrats, you won!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end
