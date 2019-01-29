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

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "------------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "------------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def position_taken?(board,index)
  !(board[index] == " " || board[index] == "")
end

def valid_move?(board, index)
  if index.between?(0,8)
    !position_taken?(board, index)
  end
end

def move(board, index, char)
    board[index] = char
end

def turn_count(board)
  counter = 0
  board.each_with_index do |e,i|
    if position_taken?(board, i)
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
      return "X"
  else
      return "O"
  end
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
  
def won?(board)
    WIN_COMBINATIONS.each do |wc|
        i1 = wc[0]
        i2 = wc[1]
        i3 = wc[2]
        if board[i1] == "X" && board[i2] == "X" && board[i3] == "X" 
        return wc
        elsif board[i1] == "O" && board[i2] == "O" && board[i3] == "O" 
        return wc
        end
    end
    return false
end

def full?(board)
    board.all?{|e| e == "X" || e == "O"}
end

def draw?(board)
    full?(board) && !won?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
    if arr = won?(board)
        return board[arr[0]]
    end
end

def play(board)
    until over?(board)
        turn(board)
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif 
        puts "Cat's Game!"
    end
end