def display_board(board = Array.new(9, " "))
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, player = 'X')
  index = position.to_i - 1
  board[index] = player
end

def position_taken?(board, index)
  return false if index == "" ||
                  board[index] == " "
  true
end

def valid_move?(board, position)
  index = position.to_i - 1
  return true unless position =~ /\D/ ||
                     position.to_i > board.length ||
                     position_taken?(board, index) == true 
  false
end

def turn(board)
  puts 'Please enter 1-9:'
  player_move = gets.strip
  turn(board) unless valid_move?(board, player_move)

  marker = turn_count(board).even? ? 'X' : 'O'

  move(board, player_move, marker)

  display_board(board)

end


def turn_count(board)
  count = 0 

  board.each_with_index do |cell, index|
    count += 1 if cell.include?('X') || cell.include?('O')
  end

  count
end

def current_player(board)
  turn = turn_count(board)

  if (turn + 1).odd? || turn == 0
    return 'X'
  else
    return 'O'
  end 
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    combination_result = []
    combination.each do |index|
      combination_result << board[index]
    end

    return combination if combination_result.all?{ |cell| cell == 'X' } ||
                                 combination_result.all?{ |cell| cell == 'O' }
  end

  false
end

def full?(board)
  return true if board.none?{ |cell| cell == " " }
  false
end

def draw?(board)
  return true if full?(board) && !won?(board)
  false
end

def over?(board)
  return true if draw?(board) || won?(board)
  false
end

def winner(board)
  winner_combo = won?(board)

  return board[winner_combo[0]] unless winner_combo == false
  nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if !won?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end