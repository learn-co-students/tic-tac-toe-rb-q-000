WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]}    "
  puts "----------- "
  puts " #{board[3]} | #{board[4]} | #{board[5]}    "
  puts "----------- "
  puts " #{board[6]} | #{board[7]} | #{board[8]}    "
end

def move(board, position, player_character='X')
  board[position.to_i - 1] = player_character
  board
end

def position_taken?(board, position)
  return false if [nil, "", " "].include?(board[position])
  return true if board[position] == "X" || board[position] == "O"
end

def valid_move?(board, move)
  if (1..9).to_a.include?(move.to_i)
    return true if board[move.to_i - 1] == " "
  else
    return false
  end
end

def turn(board)
  begin
    puts "Please enter 1-9:"
    input = gets.strip
  end until valid_move?(board, input)
  move(board, input, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.select {|position| position != " "}.count
end

def current_player(board)
  return "X" if turn_count(board) % 2 == 0
  return "O" if turn_count(board) % 2 != 0
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    return combo if combo.all? {|position| board[position] == 'X'}
    return combo if combo.all? {|position| board[position] == 'O'}
  end
  return false if board.all? { |position| position != " "}
  return false if board.all? { |position| position == " "}
end

def full?(board)
  return true if board.none? {|position| position == " "}
end

def draw?(board)
  return false unless full?(board) && !won?(board)
  return true unless won?(board)
end

def over?(board)
  return false unless won?(board) || full?(board)
  return true
end

def winner(board)
  return nil unless won?(board)
  return 'X' if board[won?(board)[0]] == 'X'
  return 'O' if board[won?(board)[0]] == 'O'
end

def play(board)
  while !over?(board) && !draw?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if winner(board)
  puts "Cats Game!" if draw?(board)
end