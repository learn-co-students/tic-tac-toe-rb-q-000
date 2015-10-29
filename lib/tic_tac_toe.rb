WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,4,8],  # Diagonal from top left to bottom right
  [6,4,2],  # Diagonal from top right to bottom left
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8]  # Right column
]

# Displays the board

board = [" "," "," "," "," "," "," "," "," "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------------------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------------------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def current_player(board)
    if turn_count(board) == 0
        return "X"
    elsif turn_count(board) % 2 == 1
        return "O"
    elsif turn_count(board) % 2 == 0
        return "X"
    end
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
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
    counter = 0
    for position in board
        if position == "X" || position == "O"
            counter += 1
        end
    end
    return counter
end

def won?(board)
  WIN_COMBINATIONS.each do |c|
    win = c.all? do |position|
      position_taken?(board,position) && (board[position] == board[c[0]])
    end
    if win
      return c
    end
  end
  return false
end


def full?(board)
  @board = board
  if @board.any? {|x| x == "" || x == " "}
    return false 
  else 
    return true
  end
end

def draw?(board)
  draw = false
    if full?(board)
      draw = true
      puts "Cats Game!"
    end
    if won?(board)
      draw = false
    end
  draw
 end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winner = nil
    if won?(board)
      winner = board[won?(board)[0]]
    end
  winner
end

character = current_player(board)

def move(board, position, character)
  position = position.to_i
  position = position -1 
  board.delete_at(position)
  board.insert(position, character)
  return board
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game"
  end
end
