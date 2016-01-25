  WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #Middle row
    [6,7,8], #Bottom row
    [0,4,8], #L>R diagonal
    [2,4,6], #R>L diagonal
    [0,3,6], #Left colomn
    [1,4,7], #Middle diagonal
    [2,5,8] #Right diagonal
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,position,character = "X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    true
  else board[position] == " " || "" || nil
    false
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1,9) && !position_taken?(board, (position.to_i-1))
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |character|
    if character == "X" || character == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == board[combination[1]] &&
    board[combination[1]] == board[combination[2]] &&
    position_taken?(board, combination[0])
  end
end

def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end


def winner(board)
  if win_ner = won?(board)
    board[win_ner.first]
  end
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