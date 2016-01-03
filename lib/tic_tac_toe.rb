WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
  ]

def  display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
  board[position.to_i - 1] = char
end

def position_taken?(board, position)
  board[position] == nil || board[position] == " " || board[position] == "" ? false : true
end

def valid_move?(board, position)
  !position_taken?(board, position.to_i - 1) && (position.to_i - 1).between?(0, 8) ? true : false
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

def won?(board)
  WIN_COMBINATIONS.detect do |win|
    if board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]] && position_taken?(board, win[0])
      return win
    end
  end
end


def full?(board)
  board.all? {|char| char == "X" || char == "O"}
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning = won?(board)
    board[winning[0]]
  end
end

def turn_count(board)
  count = 0
  board.each do |check|
    if check == "X" || check == "O"
      count +=1
    else
      next
    end
  end
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
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