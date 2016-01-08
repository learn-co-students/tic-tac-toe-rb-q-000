def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def move(board, input, character = "X")
  location = (input.to_i) - 1
  board[location] = character
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


def valid_move?(board, position)
  if position.to_i.between?(1,9) && position_taken?(board, position.to_i - 1) == false
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  position = input

  if valid_move?(board, position)
    character = current_player(board)
    move(board, input, character)
  else
   turn(board)
  end 
  display_board(board)
end

def turn_count(board)
  turns_played = 0
    board.each do |space|
      if space == "X" || space == "O"
        turns_played += 1
      end
  end
 turns_played
end

  def current_player(board)
  if turn_count(board).to_i % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
   if win_combination.all? {|location| board[location] == "X" || win_combination.all? {|location| board[location] == "O"}}
    return win_combination
    end
  end
  if board.all? {|spot| spot == "X" || spot == "O"}
    return false
  end
end

def full?(board)
   if board.all? {|spot| spot == "X" || spot == "O"}
    return true
    end
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.any? {|location| board[location] == " " || win_combination.any? {|location| board[location] == "" || win_combination.any? {|location| board[location] == nil}}}
      return false
    end
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  elsif !!won?(board) == false && full?(board) == false
    return false
  elsif won?(board)
    return false
  end
end


def over?(board)
  if !!won?(board) == true || full?(board) == true || draw?(board) == true
    return true
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? {|location| board[location] == "X"}
      return "X"
    elsif win_combination.all? {|location| board[location] == "O"}
      return "O"
    end
  end
    if !!won?(board) == false
      return nil
    end
end

  def play(board)
    until over?(board) == true
      turn(board)
    end

    if draw?(board) == true
      puts "Cats Game!"
    end

    if won?(board)
      if winner(board) == "X"
        puts "Congratulations X!"
      elsif winner(board) == "O"
        puts "Congratulations O!"
      end
    end
  end
