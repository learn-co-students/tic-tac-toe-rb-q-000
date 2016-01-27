WIN_COMBINATIONS = [
  [0,1,2],
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [3,4,5],
  [6,7,8],
  [6,4,2]
]

def display_board(board)
  puts   " #{board[0]} ""|"" #{board[1]} ""|"" #{board[2]} "
  puts              "-----------"
  puts   " #{board[3]} ""|"" #{board[4]} ""|"" #{board[5]} "
  puts              "-----------"
  puts   " #{board[6]} ""|"" #{board[7]} ""|"" #{board[8]} "
end

def move(board, location, player = 'X')
  board[location.to_i-1] = player
end

def position_taken?(board, location)
  if !(board[location].nil? || board[location] == " " || board[location] == "")
    true
  else
    false
  end
end

def valid_move?(board, input)
  input.to_i.between?(1,9) && !position_taken?(board, input.to_i-1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
      turn(board)
  end
    move(board, input, current_player(board))
    display_board(board)
end

def turn_count(board)
  board.count{|turns| turns=="X" || turns=="O"}
end


# def turn_count(board)
#     count = 0
#   board.each do |x| if x == "X" || x == "O"
#     count = count + 1
#   end
# end
#     count
# end

def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)

  WIN_COMBINATIONS.each do | win_combination |

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  false
end

# def won?(board)
#   WIN_COMBINATIONS.each do |win_combo|
#     if win_combo.all? {|index| board[index] == "X" }
#       return win_combo
#     elsif win_combo.all? {|index| board[index] == "O"}
#        return win_combo
#     end
#   end
#   false
# end

def full?(board)
  if board.all? { |all| all == "X" || all == "O" } && !won?(board)
    return true
  else
    return false
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combo|
    if win_combo.all? {|index| board[index] == "X" }
       return "X"
    elsif win_combo.all? {|index| board[index] == "O"}
       return  "O"
    end
    end
    nil
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
