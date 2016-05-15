WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array, position, value)
  a = position.to_i - 1
  array[a] = value
end

def position_taken?(board, position)
  positiones = position.to_i
  if board[positiones] == " " || board[positiones] == "" || board[positiones] == nil
    false
  else
    true
  end
end

def valid_move?(board,position)
  positiones = position.to_i - 1
  if position_taken?(board,positiones) == false && positiones.between?(0,8)
    true
  else
    false
  end
end

def turn(tic)
  puts "Please input position number (1-9)!"
  post = gets.strip
  position = post.to_i
  if valid_move?(tic,position)
    move(tic, position, current_player(tic))
    display_board(tic)
  else
    puts "INPUT ERROR!"
    turn(tic)
  end
end

def turn_count(board)
  i = 0
  board.each do |post|
    "#{post}" == "X" || "#{post}" == "O" ? i += 1 : i += 0
  end
  i
end

def current_player(board)
  turn_count(board).even? ? mark = "X" : mark = "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |checkloc|
    if (board[checkloc[0]] == "X" && board[checkloc[1]] == "X" && board[checkloc[2]] == "X") || (board[checkloc[0]] == "O" && board[checkloc[1]] == "O" && board[checkloc[2]] == "O")
      return checkloc
    end
  end
  nil
end

def full?(board)
  board.all? { |e|  e =="X" || e == "O"}
end

def draw?(board)
  a = won?(board)
  b = full?(board)
  if b && !a
    true
  else
    false
  end
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
    won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
