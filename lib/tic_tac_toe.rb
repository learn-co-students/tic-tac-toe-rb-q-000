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

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def welcome
  puts "Welcome to Tic Tac Toe!"
end

def empty_board
     puts "  |  |  \n-----------\n  |  |  \n-----------\n  |  |  \n"
 end

 def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
 end

def input_to_index(input)
   input.to_i - 1
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  else
    return true
end
end


def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8)
    return true
  else
    return false
end
end

def move(board, input, token)
  board[input] = token
  display_board(board)

end


def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets)

  if valid_move?(board,index) == true
    token = current_player(board)
    move(board, index, token)
  elsif valid_move?(board, index) == false
    while valid_move?(board,index) == false
    puts "Invalid move. Please enter 1-9:"
    index = gets.to_i
    end
    token = current_player(board)
    move(board, index, token)
   end

end

def turn_count(board)
  count = board.select {|move| move == "X" || move == "O"}
  return count.size
end



def current_player(board)
  if turn_count(board) == 0
    return "X"
  elsif turn_count(board) == 1
    return "O"
 elsif turn_count(board) == 3
   return "X"
 elsif
    turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end



def current_player(board)
  if turn_count(board) == 0
    return "X"
  elsif turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]

        if position_1 == "X" && position_2 == "X" && position_3 == "X"
          return true
        elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
          return true
        end
  end
  return false
end

def full?(board)
  if board.any? {|i| i == " "}
    return false
  else
    return true
end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  elsif won?(board) == true
    return false
  else
    return false
  end
end

def over?(board)
  if full?(board) == true || draw?(board) == true || won?(board) == true
    return true
  end
end

def winner(board)
    WIN_COMBINATIONS.each do |win_combination|
          win_index_1 = win_combination[0]
          win_index_2 = win_combination[1]
          win_index_3 = win_combination[2]

          position_1 = board[win_index_1]
          position_2 = board[win_index_2]
          position_3 = board[win_index_3]

          if position_1 == "X" && position_2 == "X" && position_3 == "X"
            puts "Congratulations X!"
            return "X"
          elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
            puts "Congratulations O!"
            return "O"
          end
    end
    return nil
  end

  def play(board)
    until over?(board) == true
        turn(board)
      end
    if won?(board) == true
      winner(board)
    end
    if draw?(board) == true
      puts "Cats Game!"
    end
  end
