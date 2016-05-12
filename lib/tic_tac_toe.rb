WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(array)
  counter = 0
  2.times do
    puts " #{array[counter]} | #{array[counter+1]} | #{array[counter+2]} "
    puts "-----------"
    counter += 3
  end
  puts " #{array[counter]} | #{array[counter+1]} | #{array[counter+2]} "
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count+=1
    end
  end
  count
end

def move(board, pos, char)
  board[pos-1] = char
end

def position_taken?(array,pos)
  !(array[pos] == " " || array[pos] == "" || array[pos] == nil)
end

def valid_move?(array,pos)
  (pos.to_i >= 1 && pos.to_i <= 9 && position_taken?(array,pos.to_i-1) == false)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  until valid_move?(board,input)

    puts "Invalid move! Please enter 1-9:"
    display_board(board)
    input = gets.strip
  end
  move(board, input.to_i, current_player(board))
  display_board(board)
end

def current_player(board)
  turns = turn_count(board)
  turns.even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect { |index| (board[index[0]] == "X" && board[index[1]] == "X" && board[index[2]] == "X") || (board[index[0]] == "O" && board[index[1]] == "O" && board[index[2]] == "O") }
end

def full?(board)
  !(board.any? { |space| space.nil? || space == " " })
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board).class == Array ? board[won?(board)[0]] : nil
end

def play(board)
  display_board(board)

  while !over?(board)
    turn(board)
  end

  if winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
