# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  false
end


def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end


def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end


def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true
  else
    false
  end
end


def winner(board)
  if won?(board)
    winning_combination = won?(board)
    winner = board[winning_combination[0]]
    return winner
  end
end


def move(board, position, char = "X")
  position = position.to_i-1
  board[position] = char
  board
end


def turn(board)
puts "Please enter 1-9:"
input = gets.strip.to_i

until valid_move?(board, input)
  puts "Please enter a valid number,  1-9:"
  input = gets.strip.to_i
end
player = current_player(board)
move(board, input, player)
display_board(board)
end


def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end


def turn_count(board)
  count = 0
  board.each do |square|
    if square == "X" or square == "O"
      count +=1
    end
  end
  return count
end



def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end


def play(board)
  while !over?(board)
  turn(board)
end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end