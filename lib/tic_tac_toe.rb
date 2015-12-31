def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, character="X") 
  character = current_player(board)
  board[location-1] = character
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position = position.to_i
  if position.between?(1,9) && !position_taken?(board, position-1)
    return true
  end
  return false
end

def turn(board)
    puts "Please enter 1-9:"
    position = gets.strip
    position = position.to_i
    if valid_move?(board, position.to_s)
        move(board, position)
    else
        turn(board)
    end
    display_board(board)
end

def turn_count(board)
  count = 0
  board.each {|position| 
    if position != " "
      count +=1
    end
  }
return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

WIN_COMBINATIONS = [
[0, 1, 2], 
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[2, 4, 6]
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combo_array|
    count = 0
      win_combo_array.each do |win_elements|
        if board[win_elements] == "X"
          count +=1
        end
     end

      if count == 3 || count == 0 && position_taken?(board, win_combo_array[0]) && position_taken?(board, win_combo_array[1]) && position_taken?(board, win_combo_array[2])
        return win_combo_array
      end
    end  
  return false
end

def full?(board)
  board.none? {|location| location == " "}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board) 
    turn(board)
    won?(board)
    draw?(board)
  end
    if won?(board)
      puts "Congratulations " + winner(board) + "!"
    elsif draw?(board)
      puts "Cats Game!"
    end
end

