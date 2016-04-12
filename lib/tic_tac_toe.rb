def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter.to_i
end

def current_player(board)
  if turn_count(board).even?
    current_player = "X"
  else
    current_player = "O"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    current_player = current_player(board)
    move(board, input, current_player)
  else
    turn(board)
  end
  display_board(board)
end

def play(board)
  until over?(board)
    turn (board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"      
  end
end

WIN_COMBINATIONS = [
  [0, 1, 2], #top 
  [3, 4, 5], #middle
  [6, 7, 8], #bottom
  [0, 3, 6], #left
  [1, 4, 7], #middle down
  [2, 5, 8], #right
  [2, 4, 6], #first diag
  [0, 4, 8]  #last diag
]

def won?(board)
  match = WIN_COMBINATIONS.select do |e|
    e.all? {|i| board[i.to_i] == "X"} || e.all? {|i| board[i.to_i] == "O"}
  end
  if match == []  
    match = nil
  else
    match = match[0]
  end
end

def full?(board)
  if board.all? { |cell| cell == "X" || cell == "O"}
    true
  else
    false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else 
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if over?(board) == true && won?(board) != nil
    match = WIN_COMBINATIONS.select do |e|
    e.all? {|i| board[i.to_i] == "X"} || e.all? {|i| board[i.to_i] == "O"}
    end
    who_won = board[match[0][0]]
    who_won = who_won.to_s
  else
    who_won = nil
  end
end