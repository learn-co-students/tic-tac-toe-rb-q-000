
def turn (board)
  # ask for input
  puts "Please enter 1-9:"
  # get input
  input = gets.strip
  # if input is valid
  if valid_move?(board, input)
     move(board, input, char = "X") #   make the move for input
  else 
    # ask for input again until you get a valid input
    until valid_move?(board, input)
      turn (board)
      break
    end
  end 
  # show the board
  display_board(board)
end
