WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  #Bottom row
  [0,3,6],  #Left columns
  [1,4,7],  #Center column
  [2,5,8],  #Right column
  [0,4,8],  #Left diagonal
  [2,4,6]  #Right diagonal
]

def display_board(index)

  line_1 = " #{index[0]} | #{index[1]} | #{index[2]} "
  line_2 = "-----------"
  line_3 = " #{index[3]} | #{index[4]} | #{index[5]} "
  line_4 = "-----------"
  line_5 = " #{index[6]} | #{index[7]} | #{index[8]} "

  puts line_1
  puts line_2
  puts line_3
  puts line_4
  puts line_5
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if
   board[index] == "X"
    true
  elsif
    board[index] == "O"
    true
  else
    board[index] == " " || "" || nil
    false
  end
end

def valid_move?(board, index)
  # nb: Arugments for position_taken.
    if index.between?(0,8) && (position_taken?(board, index) == false)
      true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, value = current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each {|index|
   if index == "X" || index == "O"
    counter += 1
  end
}
  return counter
end

def current_player(board)
turn = turn_count(board)
  if turn % 2 == 0
    return "X"
  else
   return "O"
 end
end

def won?(board)
  WIN_COMBINATIONS.each { |win_group|
    if (board[win_group[0]] == "X"  && board[win_group[1]] == "X"  && board[win_group[2]] == "X") || (board[win_group[0]] == "O" && board[win_group[1]] == "O" && board[win_group[2]] == "O")
      return win_group
    end
  }
return false
end

def full?(board)
  board.none? {|index| index == " "}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each { |win_group|
    if (board[win_group[0]] == "X"  && board[win_group[1]] == "X"  && board[win_group[2]] == "X") || (board[win_group[0]] == "O" && board[win_group[1]] == "O" && board[win_group[2]] == "O")
      return board[win_group[0]]
     end
    }
    return nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board) && winner(board) == "X"
    puts "Congratulations X!"
  elsif won?(board) && winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
