
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
  ]

def display_board(board = [" "," "," "," "," "," "," "," "," "])
  print " #{board[0]} |" + " #{board[1]} |" + " #{board[2]} \n------------\n"
  print " #{board[3]} |" + " #{board[4]} |" + " #{board[5]} \n------------\n"
  print " #{board[6]} |" + " #{board[7]} |" + " #{board[8]} \n------------\n"
end


def move (board, position, player_id="X")
  #if valid_move?(board, position) == true
    board[(position.to_i - 1)] = player_id
    return board
  #end
end


def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
    #puts "That one's taken."
end


def valid_move?(board, position)
  if position.to_i.between?(1, 9) == false
    #puts "not on the board"
    return false
  elsif position_taken?(board, position.to_i - 1) == true
    return false
  else
    return true
  end
end


def turn(board)
  player_id = current_player(board)
  puts "Make your move, player #{current_player(board)}. Enter 1-9."
  position = gets.strip
  if valid_move?(board, position) == false
    puts "Try again."
    turn(board)
  else
    move(board, position, player_id)
    display_board(board) 
  end
end


def turn_count(board)
  count = 0
  board.each do |position|
    if position != " "
      count += 1
    end
  end
  return count
end


def current_player(board)
  (turn_count(board) + 1).even? ? "O" : "X" 
end


def won?(board)
  if board.all? {|position| position == " "}
    
    return false
  elsif WIN_COMBINATIONS.each {|winning_array|
    if winning_array.all? {|position| board[position] == "X" }
      puts "Congratulations X!"
      return winning_array
    elsif winning_array.all? {|position| board[position] == "O"}
      puts "Congratulations O!"
      return winning_array
    end
      }
    return false
  end    
end


def full?(board)
  WIN_COMBINATIONS.all? {|winning_array|
    winning_array.all?{|position| position_taken?(board, position)}
  }
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    puts "Cats Game!"
    return true
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    #puts "Congratulations #{board[won?(board).to_a[0]]}!"
    return board[won?(board).to_a[0]]
  end
end

#=begin
def play(board)
  until over?(board)
    turn(board)
  end
end
#=end


