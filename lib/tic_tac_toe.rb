# Helper Methods

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]]

#Displays the current state of board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Method executes player turn and updates board
def move(board,user_input,user_char = "X")
  user_input = user_input.to_i
  user_input-=1
  board[user_input] = user_char
end

#Method takes board and user input as arguments
#Checks to see if position is taken
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " " || board[location] == "")
end

#Takes board and user_input arguments
#Determines if arguments allow for a valid move
def valid_move?(board,user_input)
  user_input = user_input.to_i
  if user_input.between?(1,9) && position_taken?(board,user_input -1) == false
    return true
  else
    return false
  end
end

#Takes board as argument
#Accepts 1-9 as input and updates board once validated
#If not valid, will ask for new input
def turn(board)
  puts "Please enter 1-9:"
  boolCheck = false
  while boolCheck == false
    user_input = gets.strip
    if valid_move?(board,user_input) == false
      puts "Not a valid choice. Please try again"
    else
      boolCheck = true
      move(board,user_input,current_player(board))
      display_board(board)
    end
  end
end

#Accepts board as argument
#Checks board to determine current turn num.
def turn_count(board)
  counter = 0
  board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end
  end
  return counter
end

#Takes board as argument
#Determines current character of Player(X or O)
def current_player(board)
  turn_num = turn_count(board) + 1
  if turn_num.even? == true
    return "O"
  else
    return "X"
  end
end

#Method that takes board argument
#Uses WIN_COMBINATIONS  to check for victory conditions
def won?(board)
  WIN_COMBINATIONS.each_with_index do |element,index|
    if position_taken?(board,element[0]) == true
      if board[element[0]] == board[element[1]] && 
        board[element[1]] == board[element[2]]
        return WIN_COMBINATIONS[index]
      end
    end
  end
  return false
end

#Takes board as argument
#Checks to see if there is no empty space on board
def full?(board)
  board.all? do |index|
    index == "X" || index == "O"  
  end
end

#Takes baord as argument
#Checks to see if board is full and satisfies draw condition
def draw?(board)
   won?(board) == false && full?(board) == true
end

#Accepts board argument
#Uses won? method and draw? to determine game over
def over?(board)
  won?(board).class == Array || draw?(board) == true
end

#Takes board argument
#Uses won? to determine which player won(if at all)
def winner(board)
  win_char = nil
  if won?(board).class == Array
    win_char = board[won?(board)[0]]
  end
  return win_char
end

#Takes board as argument
#modify code to fit new conditions
def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board).class == Array
    puts "Congratulations #{winner(board)}"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end



