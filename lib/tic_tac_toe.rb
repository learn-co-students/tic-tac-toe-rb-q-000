WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],
  [6,7,8],[0,3,6],
  [1,4,7],[2,5,8],
  [0,4,8],[2,4,6]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
  board[position.to_i-1] = char
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, location)
    if location == "invalid"
    false
    elsif board[location.to_i-1] == " "
    true
else false
end
end

def turn(board)
  puts "Please enter 1-9:"
  location = gets.strip
  if !!(valid_move?(board, location))
    then
    if current_player(board) == "O" then char = "O"
    else char = "X"
    end
    move(board, location, char)
else
      turn(board)
end
    puts display_board(board)
  end

  def turn_count(board)
    board.count {|item| item == "X" || item == "O"}
end

  def current_player(board)
    if turn_count(board).even? || turn_count(board) == 0
      return "X"
    else return"O"
  end
  end

  def won?(board)
  WIN_COMBINATIONS.each do |combo|
lotto = [board[combo[0]], board[combo[1]], board[combo[2]]]

    if lotto.all? {|a| a == "X"} || lotto.all? {|a| a == "O"}
    return combo
end
end
else false
end

def full?(board)
    if (board.count {|item| item == "X" || item == "O"}) == 9
        then true
    else false
    end
 end

def draw?(board)
  if won?(board) == true
    false
  elsif won?(board) == false && full?(board) == true
    true
  else false
  end
end

def over?(board)
    if !!won?(board) || !!draw?(board) == true
      true
    else false
    end
  end

def winner(board)
  WIN_COMBINATIONS.each do |combo|
lotto = [board[combo[0]], board[combo[1]], board[combo[2]]]

    if lotto.all? {|a| a == "X"} == true
      return "X"
    elsif lotto.all? {|a| a == "O"} == true
      return "O"
    end
  end
else nil
end

def play(board)
until over?(board) == true
    turn(board)
end
if won?(board) == true
  winner(board)
elsif draw?(board) == true
  puts "Cats Game!"
end
  if winner(board) == "X"
  puts "Congratulations X!"
  elsif winner(board) == "O"
  puts "Congratulations O!"
end
end