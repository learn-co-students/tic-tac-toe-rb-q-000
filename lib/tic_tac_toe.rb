WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def  display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, player = "X")
  return board[location.to_i - 1] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def turn(board)
  puts "Player #{current_player(board)}, please enter 1-9:"
  input = gets
  if valid_move?(board, input) == false
    turn(board)
  elsif current_player(board) == "X"
        move(board, input, "X")
        display_board(board)
  elsif  current_player(board) == "O"
        move(board, input, "O")
        display_board(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |position|
    if position != "" && position != " " && position != nil
     turns+= 1
    end
  end
  return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
    else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |firstlevel|
    if board[firstlevel[0]] == "X" && board[firstlevel[1]] == "X" && board[firstlevel[2]] == "X"
      return firstlevel
    elsif board[firstlevel[0]] == "O" && board[firstlevel[1]] == "O" && board[firstlevel[2]] == "O"
      return firstlevel
    end
  end
  return false
end

def full?(board)
  if board.include?("") || board.include?(" ") || board.include?(nil)
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true || won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)
    thewinner = won?(board)
    if thewinner != false
      if board[thewinner[0]] == "O"
        return "O"
      elsif board[thewinner[0]] == "X"
        return "X"
      end
    end
end

def play(board)
  if draw?(board) == true
      puts "Cats Game!"
    else
      puts "Congratulations #{winner(board)}!"
    end
  until over?(board) == true
    turn(board)
    if draw?(board) == true
      puts "Cats Game!"
    else
      puts "Congratulations #{winner(board)}!"
    end
  end
end





















