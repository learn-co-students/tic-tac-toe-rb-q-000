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


def move(board, location, character = "X")
  board[location.to_i-1] = character
end



def valid_move?(board, position)
  position = position.to_i
  index = position - 1
  if position.between?(1,9)
    if position_taken?(board, index)
      return false
    else
      return true
    end
  end
end


def position_taken?(board, position)
  if board[position] == "" || board[position] == " " || board[position] == nil
    return false
  else
    return true
  end
end



def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end


def turn_count(board)
   counter = 0
   board.each do |position|
     while position == "X" || position == "O"
       counter += 1
       break
     end
   end
   return counter
end



def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def won?(board)
    WIN_COMBINATIONS.each do |combo|
      win_index_1 = combo[0]
      win_index_2 = combo[1]
      win_index_3 = combo[2]

      position_1 = board[win_index_1] 
      position_2 = board[win_index_2] 
      position_3 = board[win_index_3] 

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return combo

      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return combo

      end
    end
  return false
end


def full?(board)
  if board.any?{|value| value == " "}
    return false
  end
    return true
end


def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  end
  if won?(board) != false
    return false
  end
  false
end



def over?(board)
  if won?(board) != false || full?(board) == true || draw?(board) == true
    return true
  end
end



def winner(board)
  if won?(board) != false

    WIN_COMBINATIONS.each do |combo|
  
      win_index_1 = combo[0]
      win_index_2 = combo[1]
      win_index_3 = combo[2]

      position_1 = board[win_index_1] 
      position_2 = board[win_index_2] 
      position_3 = board[win_index_3] 
    
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
         return "X"
    
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
          return "O"
      end
    end
    else return nil
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