WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]

def play(board)

    until over?(board) do
        turn(board)
    end

    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cats Game!"
    end
end




def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


def display_board(results = [" "]*9)
  puts "  #{results[0]} | #{results[1]} | #{results[2]} "
  puts "------------"
  puts "  #{results[3]} | #{results[4]} | #{results[5]} "
  puts "------------"
  puts "  #{results[6]} | #{results[7]} | #{results[8]} "
end

def move(board, location,player = "X")
  board[location.to_i-1] = player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  input = position.to_i - 1
  if !input.between?(0,8)
    false
  elsif position_taken?(board, input)
    false
  else
    true
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" ||position == "O"
      count += 1
    else
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  index =[0,1,2,3,4,5,6,7,8]
  x_pos = index.select {|position| board[position] == "X"}
  o_pos = index.select {|position| board[position] == "O"}
  WIN_COMBINATIONS.each do |combination|
    #puts combination.inspect
    if combination.all? {|position| x_pos.include?(position)} || combination.all? {|position| o_pos.include?(position)}
      return combination
    else
    end
  end
  return false
end

def full?(board)
  if board.all? {|position| position == "X" || position =="O" }
    true
  else
    false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif won?(board)
    false
  elsif !won?(board) && !full?(board)
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  elsif
    false
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    index =[0,1,2,3,4,5,6,7,8]
    x_pos = index.select {|position| board[position] == "X"}
    o_pos = index.select {|position| board[position] == "O"}
    WIN_COMBINATIONS.each do |combination|
    #puts combination.inspect
    if combination.all? {|position| x_pos.include?(position)}
      return "X"
    elsif combination.all? {|position| o_pos.include?(position)}
      return "O"
    else
    end
  end
end
end
