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
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, postion, char = "X")
  board[postion.to_i - 1] = char
end

def position_taken?(board, position)
  num = position.to_i
  board[num] != " " && board[num] != ""
end

def valid_move?(board, position)
  num = position.to_i
  num.between?(0, 10) && !(position_taken?(board, num-1)) && num.to_s == position
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  
  if valid_move?(board, position)
      move(board, position, char = current_player(board))
      display_board(board)            
    else 
      puts "#{position} is not a valid move."
      turn(board)
  end   
end

def turn_count(board)
  board.count {|i| i != " "}
end

def current_player(board)
  if turn_count(board).even?
    char = "X"
  else 
    char = "O"
  end 
end

def won?(board) 
  winner = []
  WIN_COMBINATIONS.each do |win|
    winner_test = [
      board[win[0]],
      board[win[1]],
      board[win[2]]
    ]  

    if winner_test.all? {|marker| marker == "X"} || winner_test.all? {|marker| marker == "O"}
      winner <<  [win[0], win[1], win[2]]
    end        
  end
  return winner[0]  
end

def full?(board)
  board.all? {|position| position != " "}
end

def draw?(board)
  !(won?(board)) && full?(board)  
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)  
  if won?(board)
    winner = board[won?(board)[0]]  
  end
end

def play(board)
  while !draw?(board) && !over?(board)
    turn(board)
  end
  if winner(board) 
    puts winner(board) == "X" ? "Congratulations X!" : "Congratulations O!"
    elsif draw?(board)
      puts "Cats Game!"
  end  
end