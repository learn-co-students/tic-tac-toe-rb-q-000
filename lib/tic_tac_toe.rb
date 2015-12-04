WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]

def display_board(board=[" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def move(board, location, player="X")
  board[location.to_i-1]=player
  board=Array.new(9,"")
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board,position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  if valid_move?(board, input)
  move(board, input)
  else
  turn(board)
end
display_board(board)
end

def turn_count(board)
plays=0
board.each do |turn|
  if turn == "X" || turn == "O"
  plays += 1
end
end
return plays
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_mix|
    win_index_1 = win_mix[0]
    win_index_2 = win_mix[1]
    win_index_3 = win_mix[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_mix
    end
    end
else
  return false
end

def full?(board)
  board.each do |position|
    if position == " "
      return false
    else
   end
end
  return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def over?(board)
  won?(board) || draw?(board) || full(board?)
end

def winner(board)
  if won?(board) && board[won?(board)[0]] == "X"
    return "X"
  elsif won?(board) && board[won?(board)[0]] == "O"
    return "O"
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end






# code your #valid_move? method here

