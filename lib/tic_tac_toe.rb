
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    input = input.to_i - 1
    index = input
    end

def move(board, index, character)
  board[index] = character
end

def turn(board)
  loop do
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
    break
    end
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8)
     true
  else
    false
  end
end

def position_taken?(board, index)
    if board[index] == "X" || board[index] == "O"
      return true
    elsif board[index] == " " || board[index] == ""
      return false
    else
      false
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

def play(board)
until over?(board) || draw?(board)
  turn(board)
end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
    end
  end

def current_player(board)
  return "X" if turn_count(board) % 2 == 0
     else
       return "O"
     end

     WIN_COMBINATIONS = [
       [0,1,2],
       [3,4,5],
       [6,7,8],
       [0,3,6],
       [1,4,7],
       [2,5,8],
       [0,4,8],
       [2,4,6],
   ]

   def won?(board)
     board_x = board.each_index.select {|i| board[i] == "X"}
     board_o = board.each_index.select {|i| board[i] == "O"}
     WIN_COMBINATIONS.each do |win_combination|
       if win_combination.all?{|w| board_x.include?(w)} || win_combination.all?{|w| board_o.include?(w)}
         return win_combination
     end
   end
   return false
   end

   def full?(board)
     board.all? do |index|
       index != " "
     end
   end

   def draw?(board)
     if !won?(board) == true && full?(board) == true
       return true
     else
       return false
     end
   end

   def over?(board)
     won?(board) || full?(board) || draw?(board)
   end

   def winner(board)
     if won?(board)
       return board[won?(board)[0]]
     end
   end
