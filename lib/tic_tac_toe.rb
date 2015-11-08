

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
                    [0,1,2],
                    [3,4,5],
                    [6,7,8],
                    [0,3,6],
                    [1,4,7],
                    [2,5,8],
                    [0,4,8],
                    [6,4,2]
                    ]

def won?(board)
  WIN_COMBINATIONS.detect {|win|
       win.all? {|i| board[i] == "X" } ||
       win.all? {|r| board[r] =="O" }}
end


def full?(board)
  board.all? { |i| i == "X" || i == "O"}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end

def over?(board)
  won?(board) ||  draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end


# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, the_player = "X")
  board[location.to_i-1] = the_player
end

def valid_move? (board, position)
  position = position.to_i - 1
  if !position.between?(0, 9) || position_taken?(board, position)
    false
  else
    true
end
end

def position_taken? (board, position)
  if  board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif
      board[position] == "X" || board[position] == "O"
    true
end
  end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
     turn(board)
  end
    player = current_player(board)
    move(board, input, player)
    display_board(board)
  else
  end

# Define your play method below


def turn_count(board)
  counter = 0
  board.each {|turn|
     if turn == "X" || turn == "O"
       counter += 1
     end}
    counter
end


def current_player(board)
 turn_count(board) % 2 == 0 ? "X" : "O"
end


def play(board)
  until over?(board)
    turn(board)
end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
end
end