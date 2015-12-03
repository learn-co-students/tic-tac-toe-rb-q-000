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

def display_board(board)

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def move(board, input, x = "X")
  value = input.to_i - 1
  board[value] = x
end

def position_taken?(board, position)
 !(board[position] == " " || board[position] == "" || board[position] == nil)
end

def valid_move?(board, position)
 move = position.to_i - 1
 position_taken?(board, move) == false && move.between?(0,8)
end 

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip
  if valid_move?(board, input.to_i)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)

  counter = 0
  board.each do |player|
    if player != "" && player != " "
       counter += 1
    end
  end
  counter
end

#note to self: the last line of a ruby method is what it returns, by default. :) 
def current_player(board)
  if turn_count(board).even? 
    "X"
  else
    "O"
  end
end
#

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination # return the win_combination indexes that won.
    end
  end
  false
end

def full?(board)
  turn_count(board) == 9 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil 
  end 
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end  
end















