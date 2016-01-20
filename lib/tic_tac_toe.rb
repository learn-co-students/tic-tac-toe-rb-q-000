WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[6,4,2],[0,3,6],[2,5,8],[1,4,7]]
  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
 board[position.to_i - 1] = char
end

def position_taken?(board, position)
  p_taken = false

  if (board[position] == "" || board[position] == " " || board[position] == nil)
    p_taken = false
  else
    p_taken = true
  end
  p_taken
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  counter = 0
  board.each do |loc|
    if loc == "X" || loc == "O"
      counter += 1
    end
  end
  return counter
end

def valid_move?(board, position)
  val_move = false
  if position.to_i.between?(1,9) &&  !position_taken?(board, position.to_i - 1)
      val_move = true
  end
  val_move
end

def position_taken?(board, position)
  p_taken = false
  if (board[position] == "" || board[position] == " " || board[position] == nil)
    p_taken = false
  else
    p_taken = true
  end
  p_taken
end

# def turn(board)
#   puts "Please enter 1-9:"
#   position = gets.strip
#   until valid_move?(board, position)
#     puts "Please choose a Correct Position - a Number Between 1-9!"
#     position = gets.strip
#   end
#   move(board, position, char ="X")
#   display_board(board)
# end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end


def won?(board)
  WIN_COMBINATIONS.detect do |win_com|
    board[win_com[0]] == board[win_com[1]] &&
    board[win_com[1]] == board[win_com[2]] &&
    position_taken?(board, win_com[0])
  end
end

def full?(board)
  !board.any?{ |f| f == " " || f == "" || f.nil? }
end
# def full?(board)
#   board.all?{|token| token == "X" || token == "O"}
# end

def draw?(board)
   if full?(board)
     if !won?(board)
       return true
       else
       return false
     end
   elsif
     !won?(board)
     return false
   else return false
   end
end



def over?(board)
  if !draw?(board)
    if !won?(board)
      return false
    else return true
    end
  else return true
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]]
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
