WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #diagonal
  [2,4,6] #diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


  def current_player(board)
    if turn_count(board).even?
      return "X"
    else
      return "O"
    end
  end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

  def turn_count(board)
    count = 0
    board.each do |token|
      if token == "X" || token == "O"
        count +=1
      end
    end
    return count
  end



  def won?(board)
    WIN_COMBINATIONS.find do |win_combination|
      if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
        win_combination
        true
      elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
        win_combination
        true
      else
        false
      end
    end
  end

  def full?(board)
    if board.include?(" ")
      return false
    else
      return true
    end

  end

  def draw?(board)
    if !won?(board) && full?(board) == true
      true
    else
      false
    end
  end

  def over?(board)
    draw?(board) || won?(board) || full?(board)
  end

  def winner(board)
    WIN_COMBINATIONS.find do |win_combination|
      if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
        return "X"
      elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
        return "O"
      else
        nil
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
      puts "Cat's Game!"
    end
  #game_number = 0
  # until game_number == 9
    # turn(board)
  #   game_number +=1
  # end
  end
