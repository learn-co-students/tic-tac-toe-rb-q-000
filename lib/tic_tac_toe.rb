# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =  [[0,1,2], #top row
                    [3,4,5], #middle row
                    [6,7,8], #bottom row
                    [0,3,6], #left column
                    [1,4,7], #middle column
                    [2,5,8], #right column
                    [0,4,8], #top-ltr diagonal
                    [2,4,6]]  #top-rtl diagonal

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
#def move(board, position, player = 'X')
def move(board, position, player = 'X')
  #player = current_player(board) #w/o this line, tictactoe spec will run properly
  position = position.to_i - 1
  board[position] = player
end

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# code your #valid_move? method here
def valid_move?(board, position)
  position = position.to_i - 1
  if position_taken?(board, position)
    return false
  else
    if position.between?(0,8) && (board[position] != "X" || board[position] != "O")
      return true
    else
      return false   
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    player = current_player(board) #w/o this line, tictactoe spec will run properly
    move(board, position, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  xo_count = 0
  board.each do |xo|
    if xo == "X" || xo == "O"
      xo_count += 1
    end
  end
  return xo_count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  empty_board_count = 0
  board.each do
    if !position_taken?(board, empty_board_count)
      empty_board_count += 1
      if empty_board_count >= 9
        return false #satisfies test for empty board, no moves made
      end
    else      
      WIN_COMBINATIONS.each do |winning_set| 
        x_count = 0
        o_count = 0
        winning_set.each do |position|
          if board[position] == "X"
            x_count += 1
            if x_count >= 3
              puts "Congratulations X!"
              return winning_set
            end
          elsif board[position] == "O"
            o_count += 1
            if o_count >= 3
              puts "Congratulations O!"
              return winning_set
            end
          end
        end   
      end
    end
  end
  return false # satisfies test of won? board is full, but no winner
end

def full?(board)
  if board.any? { |i| (i == " ") || (i == "")}
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board) 
    return false
  end
  if full?(board)
    return true
  end
end

def over?(board)
  if draw?(board)
    puts "Cats Game!"
    return true
  end
  if won?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    x_count = 0
    o_count = 0
    board.each do |xo|
      if xo == "X"
        x_count += 1
      elsif xo == "O"
        o_count += 1
      end
    end
    x_count > o_count ? (return "X") : (return "O")
  else
    return nil
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
end