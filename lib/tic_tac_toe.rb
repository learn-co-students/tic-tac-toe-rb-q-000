# Helper Method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    if (turn_count board) % 2 == 0
      move(board, index, "X")
    else
      move(board, index, "O")
    end
    display_board(board)
  else
    turn(board)
  end
end


def play(board)
  while !(over? board)
    turn(board)
  end
  if winner board
    puts"Congratulations #{winner board}!"
  else
    puts "Cats Game!"
  end
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],
                    [0,3,6], [1,4,7], [2,5,8],
                    [0,4,8], [2,4,6]]

def won? (board)
  WIN_COMBINATIONS.detect do |comb|
    board[comb[0]] != " " && board[comb[0]] == board[comb[1]] && board[comb[0]] == board[comb[2]]
   end
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn_count(board)
  counter = 0
  board.each do |symbol|
    if symbol == "X" || symbol =="O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  counter = 0
  board.each { |chr|  counter += 1 if chr != " "}
  counter % 2 == 0 ? "X" : "O"
end


def full? board
  state = true
  board.each do |cell|
    state &&= cell != " "
  end
  state
end

def draw? board
  !(won?(board)) && full?(board)
end

def over? board
  return draw?(board) || won?(board)
end


def winner board
  begin
    return board[won?(board)[0]]
  rescue
    return nil
  end
end
