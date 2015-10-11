WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    x = current_player(board)
    move(board, input, x)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each {|x| 
    if (x == "X") || (x == "O") 
      count +=1 
    end
  }
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win = combo.all? do |position|
      position_taken?(board,position) && (board[position] == board[combo[0]])
    end
    if win
      return combo
    end
  end
  return false
end

def full?(board)
  full = board.none? {|x| x == " " }
end

def draw?(board)
  draw = false
    if full?(board)
      draw = true
    end
    if won?(board)
      draw = false
    end
  draw
 end

 def over?(board)
  over = false
    if draw?(board) || won?(board) 
      over = true
    end
  over
 end

 def winner(board)
  winner = nil
    if won?(board)
      winner = board[won?(board)[0]]
    end
  winner
 end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if over?(board) == true
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cats Game!"
    end
  end

end