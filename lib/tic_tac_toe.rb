WIN_COMBINATIONS = [[0,1,2],[3,4,5],
                    [6,7,8],[0,3,6],
                    [1,4,7],[2,5,8],
                    [0,4,8],[2,4,6]]

def display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, a, character = "X" )

board[ a.to_i - 1 ] = character
end

def position_taken?(board, location)
  !(board[location.to_i].nil? || board[location.to_i] == " ")
end

def valid_move?(board, position)
  if position_taken?(board, position.to_i - 1) || (!position.to_i.between?(1, 9))
    false
    else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  a = current_player(board)
    if (valid_move?(board, position))
     move(board, position, a)
      else turn(board)
        end
display_board(board)
  end

def turn_count(board)
  counter = 0
  board.each do |element|
   if (element == "X") || (element == "O")
     counter += 1
                end
        end
counter

end

def current_player(board)
if turn_count(board) % 2 == 0
  return "X"
  elsif turn_count(board) % 2 == 1
  return "O"
end
  turn(board)
end

def won?(board)
a = 0
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
    (position_1 == "O" && position_2 == "O" && position_3 == "O")
    a = win_combination.to_ary
    false
    else
    false
      end
  end

  if board.all? { |location| location == " "}
    false
    elsif WIN_COMBINATIONS.none? { |win_combination| a == win_combination}
    false
    else return a
  end
end

def full? (board)
board.all? do |element|
  element == "X" || element == "O"
end
end

def draw?(board)
if  full?(board) && !won?(board)
  true
  elsif won?(board)
  false
  elsif !won?(board) && !full?(board)
  false
end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
    else
    false
  end
end

def winner(board)
  if !won?(board)
    return nil
elsif won?(board).all? {|index| board[index] == "X"}
 return "X"
  elsif won?(board).all? {|index| board[index] == "O"}
 return "O"
end
end

def play(board)

  if !won?(board) || !draw?(board) || !full(board)
  until over?(board) == true do
    current_player(board)
    turn(board)
              end
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
    puts "Cats Game!"
  end
  end
