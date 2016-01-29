require './lib/helper.rb'

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],
                  [3,4,5],
                  [6,7,8],
                  [0,3,6],
                  [1,4,7],
                  [2,5,8],
                  [0,4,8],
                  [2,4,6]]
                  
def won?(board)
  WIN_COMBINATIONS.each do |win_combination| 
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    # load the value of board at specified index
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == 'X' && position_2 == 'X' && position_3 == 'X'
      return win_combination
    elsif position_1 == 'O' && position_2 == 'O' && position_3 == 'O'
      return win_combination
    end
  end
  false
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, player = 'X')
  board[location.to_i-1] = player
end

def position_taken?(board, location)
  board[location] != " "
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  system "clear"
  if !valid_move?(board, input)
    turn(board)
  end
  # need to refactor
  player = current_player(board)
  move(board, input, player)
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == 'X' || cell == 'O'
      count += 1
    end
  end
  count
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) == 'X'
    puts 'Congratulations X!'
  elsif winner(board) == 'O'
    puts 'Congratulations O!'
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def current_player(board)
  !!turn_count(board).odd? ? "O" : "X"
end


