WIN_COMBINATIONS = [
  [0,1,2],
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [3,4,5],
  [6,7,8]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, position)
  post = position.to_i-1
  board_ = board[post]
  valid = true

  if post < 0 || post > 8 || position_taken?(board,post)
      valid = false
  end

  valid
end

def move(board, position, marker)
  post = position.to_i-1
  valid = valid_move?(board,position)
  if valid
    board[post] = marker
  end
  board

end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def turn(board)
    puts "Please enter 1-9:"
    position = gets.strip
    valid = valid_move?(board,position)
    if !valid
      turn(board)
    else
      move(board,position,current_player(board))
      display_board(board)
      board
    end
end

def turn_count(board)
  val = 0

  board.each do |cell|
    if cell == "X" || cell == "O"
      val = val + 1
    end
  end
  val
end

def current_player(board)
  val = turn_count(board)
  if val % 2 == 0
    "X"
    else
    "O"
  end
end

def won?(board)

  win = false
  counter = 0

  while counter < 8 && win == false
    index = WIN_COMBINATIONS[counter]
    marker = board[index[0]]
    if position_taken?(board,index[0])
      if board[index[0]] == marker && board[index[1]] == marker && board[index[2]] == marker
        win = index
      end
    end
    counter = counter + 1
  end
  win
end


def full?(board)
  index = 0
  cont = true
  while index < 9 && cont == true
    cont  = position_taken?(board, index)
    index = index + 1
  end
  cont
end

def draw?(board)
  full?(board) && !won?(board)
  val = false
  if won?(board) == false
    if full?(board)
      val = true
    end
  end
  val

end

def over?(board)
  val = false
  if won?(board) == false
    if draw?(board)
      val = true
    end
  else
    val = true
  end
  val
end

def winner(board)
  if over?(board) && !draw?(board)
    board[won?(board)[0]]
  end
end

def play(board)

  until over?(board)
    turn(board)
    draw?(board)

  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board) != false
    puts puts "Congratulations #{winner(board)}!"
  end
end
