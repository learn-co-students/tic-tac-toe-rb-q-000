# Define your WIN_COMBINATIONS constant
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

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |x|
    win_index_1 = x[0]
    win_index_2 = x[1]
    win_index_3 = x[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return x.to_a
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return x.to_a
  end
 end
  return nil
end

def full?(board)
  !board.any?{|x| x == " " || x == "" }
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board)||full?(board)||draw?(board)
end


def winner(board)
  WIN_COMBINATIONS.each do |x|
    win_index_1 = x[0]
    win_index_2 = x[1]
    win_index_3 = x[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
  end
 end
  return nil
end

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} \n-----------\n #{array[3]} | #{array[4]} | #{array[5]} \n-----------\n #{array[6]} | #{array[7]} | #{array[8]} "
end

def move(array,loc,char = "X")
  array[loc.to_i-1] = char
  return array
end

def valid_move?(array,x)
  x = x.to_i
  x -= 1
  if !position_taken?(array,x) && x.between?(0,8)
    true
    elsif position_taken?(array,x) || (x > 8 || x == -1)
    false
  end
end

def turn(array)
  puts "Please enter 1-9:"
  x = gets.chomp
  if valid_move?(array,x)
    turn_count(array) % 2 == 0 ? move(array,x) : move(array,x,"O")
  else
    turn(array)
  end
  display_board(array)

end

def turn_count(array)
  x = array.select do |y|
    y == "X" || y == "O"
  end
  x.length
end

def current_player(array)
  turn_count(array) % 2 == 0 ? "X" : "O"
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


