
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i-1
end

def move(board,index,value)
  board[index] = value
end

def position_taken?(board,index)
  if board[index] == " " || board[index] == "" or board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board,index)
  if index >= 0 && index<9 && !position_taken?(board,index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  until valid_move?(board,index)
    puts "Invalid move, please enter 1-9:"
    index = input_to_index(gets.strip)
  end
  move(board,index,current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position =="O"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if counter%2==0
    return "X"
  else return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect {|win_combination| (board[win_combination[0]]=="X" && board[win_combination[1]]=="X" && board[win_combination[2]]=="X")||(board[win_combination[0]]=="O" && board[win_combination[1]]=="O" && board[win_combination[2]]=="O")}
end

def full?(board)
  return !(board.detect {|i| i==" "||i.nil?})
end

def draw?(board)
  !won?(board)&&full?(board)
end

def over?(board)
  won?(board)||full?(board)||draw?(board)
end

def winner(board)
  wincombo = won?(board)
  if wincombo
    return board[wincombo[0]]
  else
    return wincombo
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
