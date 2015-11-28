#WIN_COMBINATIONS constant
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

#board array
board = Array.new(9, " ")

#display_board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#move
def move(board, position, current_player="X")
  board[position.to_i - 1] = current_player
end

#position_taken?
def position_taken?(board, position)
  (board[position] == "X") || (board[position] == "O") ? true : false
end

#valid_move?
def valid_move?(board, position)
position = position.to_i - 1
 position.between?(0,10) && !position_taken?(board, position) ? true : false
end

#turn
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
   else
    puts "That spot does not exist. Try again, b!"
    turn(board)
  end
  display_board(board)
end

#turn_count
def turn_count(board)
  board.count {|token| token == "X" || token == "O"}
end

#current_player
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

#won?
def won?(board)
  WIN_COMBINATIONS.any? do |win_combo|
          if (board[win_combo[0]] == "X" || board[win_combo[0]] == "O") && board[win_combo[0]]== board[win_combo[1]] && board[win_combo[1]]==board[win_combo[2]]
          return win_combo
        else
          false
        end
    
   end
  false
end

#full?
def full?(board)
  !board.any?{|position| position == " "}
end

#draw?
def draw?(board)
  !won?(board) && full?(board)
end

#over?
def over?(board)
won?(board) || draw?(board)
end

#winner
def winner(board)
  if win_combo = won?(board)
    board[win_combo.first]
  end
end

#play
def play(board)
  until over?(board)
    turn(board)
    end
 if winner(board) == "X"
  puts "Congratulations X!"
 elsif winner(board) == "O"
  puts "Congratulations O!"
 else draw?(board)
  puts "Cats Game!"
  end 
end







