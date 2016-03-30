WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ]

def display_board(board)
  puts " 1 | 2 | 3 ",
   "-----------",
" 4 | 5 | 6 ",
  "-----------",
" 7 | 8 | 9 "
  puts "          "

  puts " #{board[0]} | #{board[1]} | #{board[2]} ",
   "-----------",
" #{board[3]} | #{board[4]} | #{board[5]} ",
  "-----------",
" #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
    display_board(board)
  else over?(board) != true
    position = gets.strip
  end

end

def move(board, position, character = "X")
  board[position.to_i.pred] = character
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i.pred) && !full?(board) && !won?(board)
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def turn_count(board)
  a= board.count(" ")
   9 - a
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)

    if ["O", "X"].include?(board[WIN_COMBINATIONS[0][0]]) && board[WIN_COMBINATIONS[0][0]] ==  board[WIN_COMBINATIONS[0][1]] && board[WIN_COMBINATIONS[0][0]] ==  board[WIN_COMBINATIONS[0][2]]
     WIN_COMBINATIONS[0]
      elsif ["O", "X"].include?(board[WIN_COMBINATIONS[1][0]]) && board[WIN_COMBINATIONS[1][0]] ==  board[WIN_COMBINATIONS[1][1]] && board[WIN_COMBINATIONS[1][0]] ==  board[WIN_COMBINATIONS[1][2]]
     WIN_COMBINATIONS[1]
    elsif ["O", "X"].include?(board[WIN_COMBINATIONS[2][0]]) && board[WIN_COMBINATIONS[2][0]] ==  board[WIN_COMBINATIONS[2][1]] && board[WIN_COMBINATIONS[2][0]] ==  board[WIN_COMBINATIONS[2][2]]
     WIN_COMBINATIONS[2]
elsif ["O", "X"].include?(board[WIN_COMBINATIONS[3][0]]) && board[WIN_COMBINATIONS[3][0]] ==  board[WIN_COMBINATIONS[3][1]] && board[WIN_COMBINATIONS[3][0]] ==  board[WIN_COMBINATIONS[3][2]]
     WIN_COMBINATIONS[3]
    elsif ["O", "X"].include?(board[WIN_COMBINATIONS[4][0]]) && board[WIN_COMBINATIONS[4][0]] ==  board[WIN_COMBINATIONS[4][1]] && board[WIN_COMBINATIONS[4][0]] ==  board[WIN_COMBINATIONS[4][2]]
     WIN_COMBINATIONS[4]
    elsif ["O", "X"].include?(board[WIN_COMBINATIONS[5][0]]) && board[WIN_COMBINATIONS[5][0]] ==  board[WIN_COMBINATIONS[5][1]] && board[WIN_COMBINATIONS[5][0]] ==  board[WIN_COMBINATIONS[5][2]]
     WIN_COMBINATIONS[5]
elsif ["O", "X"].include?(board[WIN_COMBINATIONS[6][0]]) && board[WIN_COMBINATIONS[6][0]] ==  board[WIN_COMBINATIONS[6][1]] && board[WIN_COMBINATIONS[6][0]] ==  board[WIN_COMBINATIONS[6][2]]
     WIN_COMBINATIONS[6]
    elsif ["O", "X"].include?(board[WIN_COMBINATIONS[7][0]]) && board[WIN_COMBINATIONS[7][0]] ==  board[WIN_COMBINATIONS[7][1]] && board[WIN_COMBINATIONS[7][0]] ==  board[WIN_COMBINATIONS[7][2]]
     WIN_COMBINATIONS[7]

  else
      false
end
end

def full?(board)
   !(board.any? { |i| i == " "})
end

def draw?(board)
  full?(board) == true && won?(board) == false
  end

  def over?(board)
    draw?(board) == true || won?(board) != false
    end

def winner(board)
    WIN_COMBINATIONS.each do |wincom|
      return "X" if wincom.all? do |position| board[position] == "X"
      end
      return "O" if wincom.all? do |position| board[position] == "O"
      end
  end
   nil
end

def play(board)
until over?(board)
turn(board)
end
if won?(board) != false
  puts "Congratulations #{winner(board)}!"
elsif draw?(board) == true
  puts "Cats Game!"
end
end