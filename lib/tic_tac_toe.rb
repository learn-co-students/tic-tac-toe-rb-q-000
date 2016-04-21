#require 'pry'

WIN_COMBINATIONS=
  [ [0,1,2] ,
[3,4,5] ,
[6,7,8] ,
[0,3,6] ,
[1,4,7] ,
[2,5,8] ,
[0,4,8] ,
[6,4,2] ]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  turncount = board.select{|position| position if position == "X" || position == "O"}
  return turncount.size
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def move(board, location, player="#{current_player(board)}")
  location = location.to_i - 1
  board[location] = player
end

def won?(board)
  if board.all?{ |loc| loc == " " }
    return false
  end
  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]] == "X" || board[combo[0]] == "O") && board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
      return combo
    end
  end
  return false
end

def full?(board)
  if board.any?{ |loc| loc == " " }
      return false
  else
      return true
  end
end

def draw?(board)
  if won?(board) || !full?(board)
    return false
  else
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end




def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
    if valid_move?(board,position)
      move(board, position)
      display_board(board)
  elsif !valid_move?(board, position)
    position = gets.strip
  end
end




def winner(board)
  if !won?(board)
    return nil
  else
    WIN_COMBINATIONS.each do |combo|
      if (board[combo[0]] == "X" || board[combo[0]] == "O") && board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
        return board[combo[0]]
        board[combo[0]] = win
        win.detect {|winner| winner = "X" || winner = "O"}
        return winner
      end
    end
  end
end

#     binding.pry

def play(board)
  until over?(board)
      turn(board)
    end

   if draw?(board) && !won?(board)
      puts "Cats Game!"
   else puts "Congratulations #{winner(board)}!"
 end
end



