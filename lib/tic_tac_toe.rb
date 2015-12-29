# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

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
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1]                       #WON HERE
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if(position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combo
    end
  end
  return false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  current_p = current_player(board)
  if valid_move?(board, input)                  #TURN HERE
    move(board, input,current_p)
  else
    turn(board)
  end
  display_board(board)
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations " + winner(board) +"!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def move(board,position,char="X")
  board[position.to_i-1]=char                    #MOVE DEF HERE
end

def full?(board)
  board.each do |element|                        #FULL HERE
    if(element == " ")
      return false
    end
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)               #DRAW HERE
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)                #OVER HERE
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    win_arr = won?(board)[0]                   #WINNER HERE
    return board[win_arr]
  else
    puts !!won?(board)
    return nil
  end
end

def turn_count(board)
  counter = 0
  count = 0
  while counter < board.count
    if(board[counter]=="X" || board[counter]=="O")               #TURN COUNT HERE
      count +=1
    end
    counter +=1
  end
  return count
end

def current_player(board)
  if(turn_count(board)%2==0)                    #CURRENT PLAYER HERE
    return "X"
  else
    return "O"
  end
end

# code your #valid_move? method here
def valid_move?(board,position)
  if(position.to_i>0 && position.to_i<=9 && !position_taken?(board,position.to_i-1))   #VALID MOVE HERE
    return true
  else
    return false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board,position)
  if(board[position]=="X" || board[position]=="O")              #POSITION TAKEN HERE
    return true
  else
    return false
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "        # DISPLAY BOARD HERE
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end