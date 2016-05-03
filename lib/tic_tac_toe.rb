WIN_COMBINATIONS = 

[
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
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, position, current_player)
  position = position.to_i - 1
  board[position] = current_player
end


def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end


def valid_move?(board, position)
  position = position.to_i - 1
  position.between?(0,8) && !position_taken?(board, position)
end


def turn(board)
  position = nil
  until valid_move?(board, position) do
    puts "Please enter 1-9:"
    position = gets.strip

  end

  position = position.to_i
    move(board, position, current_player(board))
    display_board(board)
  
end


def play(board)
      
    until over?(board) do

      turn(board)

    end

      if won?(board)

        if winner(board) == "X"
          puts "Congratulations X!"
      
        elsif winner(board) == "O"
          puts "Congratulations O!"
        
        end
  
      elsif draw?(board)
          puts "Cats Game!"

      
      else
        return nil

      end
    
    

end

def turn_count(board)

  counter = 0

  board.each do |value|

    if value == "O" || value == "X"

    counter += 1

    end
  
  end

  return counter

end

def current_player(board)

  if turn_count(board) % 2 == 0

    "X"

  else

    "O"

  end
end

def won?(board)


  won_comb_X = board.each_index.select do |position|
    board[position] == "X"
  end

  won_comb_O = board.each_index.select do |position|
    board[position] == "O"
  end
   
  if won_comb_X == [] && won_comb_O == []
    
    return false

  elsif (WIN_COMBINATIONS.none? {|subarray| subarray & won_comb_X == subarray}) && (WIN_COMBINATIONS.none? {|subarray| subarray & won_comb_O == subarray})

    return false

  
  elsif WIN_COMBINATIONS.none? {|subarray| subarray & won_comb_X == subarray}
    return won_comb_O
    

  else
    return won_comb_X
    
    
  end
end

def full?(board)
  if board.none? do |entry|
    entry == " " || entry == ""
  end
  
    return true
    
  
  else

    return false

  end
end

def draw?(board)

  !won?(board) && full?(board)

end

def over?(board)

  if draw?(board)
    return true

  elsif won?(board)
    return true

  else

    return false

  end
end

def winner(board)

  won_comb_X = board.each_index.select do |position|
    board[position] == "X"
  end

  won_comb_O = board.each_index.select do |position|
    board[position] == "O"
  end
   

if WIN_COMBINATIONS.any? {|subarray| subarray & won_comb_X == subarray}
    
    return "X"

elsif
    WIN_COMBINATIONS.any? {|subarray| subarray & won_comb_O == subarray}
   
    return "O"


else
    return nil

  end
end


