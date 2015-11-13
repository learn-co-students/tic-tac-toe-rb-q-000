# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

#display_board method:
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#move method:
def move(board,location,char = "X")
  i = location.to_i - 1
  board[i] = char
end

#valid_move? method
def valid_move?(board, position)
 location = position.to_i - 1
  if position_taken?(board, location) == true
    false
  elsif location.between?(0,9) == false
    false
  else position_taken?(board, location) == false && location.between?(0,9) == true
    true
  end

end

#turn_count method:
def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " "
      counter += 1
    else
    end
  end
  counter
end

#current_player method:
def current_player(board)
  if turn_count(board).even?
    "X"
  else 
    "O"
  end
end
#turn method:
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board,position,current_player(board))
    display_board(board)
  else 
    turn(board)
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2], #Top Row Win
[3,4,5], #Middle Row Win
[6,7,8], #Bottom Row Win
[0,3,6], #Left Column Win
[1,4,7], #Center Column Win
[2,5,8], #Right Column Win
[0,4,8], #Top to Bottom Diagnol Win
#[2,4,6],
[6,4,2] #Bottom to Top Diagnol Win
]

#Define #won? Method here:
def won?(board)

  WIN_COMBINATIONS.each do |a|
    if a.all? {|i| board[i] == "X"} || a.all?{|i| board[i] == "O"} 
     return a
    end
  end
  return false
end

#Define #full? Method here:
def full?(board)
  board.none?{|i| i == " " }
end

#Define #draw? Method here:
def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

#Define #over? method here:
def over?(board)
  if draw?(board) == true || won?(board) != false
    return true
  end
end

#Define #winner method here:
def winner(board)
  if won?(board) == false
    return nil
  end

  a = won?(board)

  if board[a[0]] == "X"
    return "X"
  else 
    return "O"
  end
end

#play method
def play(board)
  until over?(board) == true
    turn(board)  
  end
  if draw?(board) == true
      puts "Cats Game!"
    else
      puts "Congratulations #{winner(board)}!"
    end
end