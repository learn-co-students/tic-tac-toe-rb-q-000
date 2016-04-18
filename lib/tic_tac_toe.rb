## Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    puts "Move not valid."
    turn(board)
  else
    move(board, input, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end  
  end
  counter
end

def current_player(board)
  turn_count(board).to_i.even? ? "X" : "O"
end

WIN_COMBINATIONS = [
  [0,1,2], #top row win
  [3,4,5], #middle row win
  [6,7,8], #bottom row win
  [0,3,6], #left column win
  [1,4,7], #middle column win
  [2,5,8], #right column win
  [0,4,8], #right diagonal win
  [2,4,6]  #left diagonal win
]

def won?(board)
  WIN_COMBINATIONS.detect do |win_index|
    board[win_index[0]] == board[win_index[1]] &&
    board[win_index[1]] == board[win_index[2]] &&
    position_taken?(board, win_index[0])
  end
end

def full?(board)
  board.all? { |cell| cell == "X" || "O" && cell != " " }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if !won?(board) || draw?(board) == true
    return nil
  else
    WIN_COMBINATIONS.each do |win_index|
      if win_index.all? { |i| board[i] == "X" }
        return "X"
      elsif win_index.all? { |i| board[i] == "O" } 
        return "O"
      end
    end
  end
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