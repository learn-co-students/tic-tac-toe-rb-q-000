
WIN_COMBINATIONS =[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
   turn_count = 0
   while !over?(board)
    turn(board)
     end
     if !draw?(board)
       puts "Congratulations #{winner(board)}!"
else
  puts "Cats Game!"
   end
 end

def input_to_index(input)
input = input.to_i - 1
index = input
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board,index)
!(board[index].nil? || board[index] == " ")
end

def valid_move? (board,index)
(index.between?(0, 8) && position_taken?(board, index) == false)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
counter = 0
board.each do |space|
  if space == "X" || space == "O"
    counter += 1
  end
end
counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  if !board.include?("X") && !board.include?("O")
  return false
  end

  WIN_COMBINATIONS.each do |winning_line|
      if board[winning_line.first] != " " && (board[winning_line[0]] == board[winning_line[1]]) && (board[winning_line[1]] == board[winning_line[2]])
        return winning_line.to_a
      end
   end
    return false
end


def full?(board)
return !board.include?(" ")
end


def draw?(board)
!won?(board) && full?(board)
end

def over?(board)
  if draw?(board) || full?(board)
      return true
  elsif won?(board)
      return true
  else
      return false
    end
end

def winner(board)
    if won?(board) != false
      winner = board[won?(board)[0]]
    else
      nil
    end
end
