def turn(board)
  puts "Please enter 1-9:"
  num = gets.chomp

  if(valid_move?(board, num))
    num = num.to_i
    move(board, num)
  else
    turn(board)

  end
display_board(board)
end

# code your #valid_move? method here
def valid_move?(board, position)
  position = position.to_i
 if(position.between?(1,9))
    position -=1
   if(position_taken?(board, position))
      false
   else
     true
   end
 end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
# code your #position_taken? method here!

def position_taken?(board, position)
  if(board[position] == "" || board[position] == " "  )
     false
  elsif(board[position] == nil)
      false

  else
    true
  end

end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(arr, location, character = "X")
  location = location.to_i - 1
  arr[location] = character

end
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

WIN_COMBINATIONS = [[0,1,2],
                      [3,4,5],
                      [6,7,8],
                      [0,4,8],
                      [6,4,2],
                      [0,3,6],
                      [1,4,7],
                      [2,5,8]]

def won?(board)


  WIN_COMBINATIONS.any? do |win_combination|
    win_index1 = win_combination[0]
    win_index2 = win_combination[1]
    win_index3 = win_combination[2]


    position_1 = board[win_index1]
    position_2 = board[win_index2]
    position_3 = board[win_index3]


    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
     return win_combination
    else
      false
    end
  end
end


def full?(board)
  is_full = true
  board.each do |number|
    number = number.to_i
    number +=1
    if position_taken?(board, number) == false
      is_full = false

    end
  end
  return is_full
end

def draw?(board)
  if won?(board) == false
    if full?(board) == true
      true
    elsif full?(board) == false
      false
    else
      false
    end
  end
end

def over?(board)
  if won?(board) == true || draw?(board) == true || full?(board) == true
    true
  else
    false
  end

end

def winner(board)

 if won?(board) != false
    winner = won?(board)[0]
    board[winner]
 else
 	nil
 end
end



def play(board)
  9.times do
    turn(board)
  end
end


def turn_count(board)
    count = 0
for num in board
  if position_taken(board, num) == true
    count +=1
  end
end
   
  end







