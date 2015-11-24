WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]
  ]

board = [" "," "," "," "," "," "," "," "," "]

# Helper Methods
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
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

# Def turn_count to keep track of turn #
def turn_count(board) # determine what turn it is
  turn_num = 0
  board.each do |mark|
    if mark == "X" || mark == "O"   # For each "X" or "O" in (board)
      turn_num += 1  # add 1 to turn_num
    end
  end
  return turn_num # return current turn_num
end

def current_player(board)
  if turn_count(board)%1==0 && turn_count(board).to_i.even? == true
    return "X"
  else return "O"
  end
end

def won?(board)

  WIN_COMBINATIONS.each do |win_comb|

    pos1 = board[win_comb[0]]
    pos2 = board[win_comb[1]]
    pos3 = board[win_comb[2]]

    return win_comb if pos1 == "X" && pos2 == "X" && pos3 == "X"
    return win_comb if pos1 == "O" && pos2 == "O" && pos3 == "O"
  end
  return false
end

def full?(board)
  board.all? do |str|
    str == "O" || str == "X"
  end
end

def draw?(board)
  return true if full?(board) == true && won?(board) == false
end

def over?(board)
  if full?(board) == true || won?(board) == true || draw?(board) == true
    return true
  end
end

def winner(board)
  if win_pos = won?(board)
    if board[win_pos[0]] == "X"
      return "X"
    end
    if board[win_pos[0]] == "O"
      return "O"
    end
  end
end

# Define your play method below
def play(board)
  while turn_count(board) < 9 && over?(board) == false && draw?(board) == false
    turn(board)
  end
end

=begin
Failures:
  1) ./lib/tic_tac_toe.rb #play asks for players input on a turn of the game
     Failure/Error: expect(self).to receive(:gets).at_least(:once).and_return("1")
       (#<RSpec::ExampleGroups::LibTicTacToeRb::Play:0x00000002e200e8>).gets(*(any args))
           expected: at least 1 time with any arguments
           received: 0 times with any arguments
     # ./spec/02_play_spec.rb:10:in `block (3 levels) in <top (required)>'
     # .bundle/binstubs/rspec:16:in `load'
     # .bundle/binstubs/rspec:16:in `<main>'
DOESN'T TURN(BOARD) ASK FOR INPUT!? DAFUQ
=end