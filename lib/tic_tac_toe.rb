
WIN_COMBINATIONS = [  [0,1,2],  [3,4,5],  [6,7,8],  [0,3,6],  [1,4,7],  [2,5,8],  [0,4,8],  [6,4,2]  ]

def display_board(board)
  puts board[0]
  puts " " + board[0] + " | " + board[1] + " | " + board[2] + " "
  puts "-----------"
  puts " " + board[3] + " | " + board[4] + " | " + board[5] + " "
  puts "-----------"
  puts " " + board[6] + " | " + board[7] + " | " + board[8] + " "
end

def move(board,input = 1,player = "X")
  board[input.to_i - 1] = player
end

def position_taken?(board,position)
    taken = nil
  if board[position] == " " || board[position] == "" || board[position] == nil
    taken = false
  elsif board[position] == "X" || board[position] == "O"
    taken = true
   end
 taken
 end

def valid_move?(board, position)
  taken1 = nil
  if position.to_i.between?(1,9)
    if position_taken?(board,position.to_i-1)
      taken1 = false
  else
      taken1 = true
    end
  end
  taken1
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    current_player(board)
    move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |moved|
    if moved == "X" || moved == "O"
      counter += 1
    end
 end
#   puts "tc #{counter}"
 counter
end

def current_player(board)
  turn_count(board)
#   puts turn_count(board)
    if turn_count(board) % 2 == 0
      player = "X"
    else
     player = "O"
    end
#  puts "cp #{player}"
   player
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? do |full|
    full == "X" || full == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
  if full?(board) == true && won?(board).nil?
    puts "Cats Game!"
    true
  elsif full?(board) == true && won?(board) == true
    false
  elsif full?(board) == false && won?(board) == false
    false
  end
end

def over?(board)
  if draw?(board) == true
    true
  elsif !won?(board).nil?
    true
  elsif full?(board) == false
    false
  end
end

def winner(board)
  if !won?(board).nil?
    puts "Congratulations #{board[won?(board)[0]]}!"
   board[won?(board)[0]]
  end
end

def play(board)
until (over?(board) == true) do
      turn(board)
   #       over?(board)

  end
         winner(board)
end
  #     won?(board)
#  puts "player #{counter}"
 #  move(board,input = 1,player = "X")
#         display_board(board)

       # full?(board)
#         draw?(board)
 #       turn_count(board)
    #     position_taken?(board,position)
      #   valid_move?(board, position)
 #  input = gets.strip
