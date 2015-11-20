# Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2], # Top Row
    [3,4,5], # Middle Row
    [6,7,8], # Bottom Row
    [0,4,8], # Diagonal Row # 1
    [6,4,2], # Diagonal Row # 2
    [0,3,6], # Vertical Column 1
    [1,4,7], # Vertical Column 2
    [2,5,8]  # Vertical Column 3
]

def display_board( board )
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board,cell,char="X")
  board[cell.to_i-1] = char
  puts board
end

# code your #position_taken? method here!
def position_taken?(board,pos)
  if board[pos.to_i]=="X" || board[pos.to_i] =="O"
    return true
  else
    return false
    end
end

# code your #valid_move? method here
def valid_move?(board,pos)
  if !position_taken?(board,pos.to_i-1) && pos.to_i.between?(1,9)
    return true
  elsif position_taken?(board,pos.to_i-1) && pos.to_i.between?(1,9)
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  pos = gets.chomp
  if valid_move?(board,pos)
    move(board,pos,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# turn_count method here
def turn_count(board)
  board.select {|value| value == "X" || value == "O" }.count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    return combo if combo.all? do |position| board[position] == "X" end
    return combo if combo.all? do |position| board[position] == "O" end
  end
end

def full?(board)
  board.all? do |i|
    if i == "X" || i == "O"
      true
    else
      false
    end
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
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != nil
    board[won?(board).first]
  else
    nil
  end
end


def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
end
end




