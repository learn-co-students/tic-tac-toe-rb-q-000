def position_taken?(board, position)
  !(board[position-1].nil? || board[position-1] == " ")
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
    WIN_COMBINATIONS.each do |win_line|
      win_index_1 = win_line[0]
      win_index_2 = win_line[1]
      win_index_3 = win_line[2]
      if (board[win_index_1] == "X" && board[win_index_2] =="X" && board[win_index_3] == "X") ||
         (board[win_index_1] == "O" && board[win_index_2] =="O" && board[win_index_3] == "O")
        return win_line
      end
    end
  false
end

def full?(board)
  board.each do |position|
    if position == " " || position == "" || position == nil
      return false
    end
  end
  true
end

def draw?(board)
  if won?(board)
    false
  end
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  (won?(board) || draw?(board)) ? true : false
end

def winner(board)
  if won?(board)
    win_line = won?(board)
    board[win_line[0]] == 'X' ? 'X' : 'O'
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts"-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts"-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,position,char = 'X')
  position = position.to_i
  board[position-1] = char
  #display_board(board)
end

def valid_move?(board,position)
  if position_taken?(board,position.to_i)
    false
  elsif !position_taken?(board,position.to_i) && position.to_i.between?(1,9) && position != "invalid"
    true
  else
    false
  end
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  position = gets.strip
  until(valid_move?(board,position))
    puts "Please enter 1-9:"
    position = gets.strip
  end
  position = position.to_i
  current_player(board) == 'X' ?  board[position-1] = "X" : board[position-1] ="O"
end

def turn_count(board)
  count = 0;
  board.each do |position|
    if position == 'X' || position =='O'
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  count = 0
  until count == 9 || over?(board)
    turn(board)
    count += 1
  end
  if won?(board)
    if winner(board) == 'X'
      display_board(board)
      puts "Congratulations X!"
    else
      display_board(board)
      puts "Congratulations O!"
    end
  end
  if draw?(board)
    display_board(board)
    puts "Cats Game!"
  end
end