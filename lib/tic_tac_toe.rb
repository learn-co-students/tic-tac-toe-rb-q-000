# Helper Method

# WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #Vertical row 0,3,6
  [1,4,7], #Vertical row 1,4,5
  [2,5,8], #Vertical row 2,5,8
  [0,4,8], #Diagonal line 0,4,8
  [2,4,6]  #Diagonal line 2,4,6
  ]

#display method
def display_board(board)
   puts " #{board[0]} " "|" " #{board[1]} " "|" " #{board[2]} "
   puts "-----------"
   puts " #{board[3]} " "|" " #{board[4]} " "|" " #{board[5]} "
   puts "-----------"
   puts " #{board[6]} " "|" " #{board[7]} " "|" " #{board[8]} "
end

#move method
def move( array, position, value = "X" )
    position = position.to_i
    array[position - 1] = value
end

#position_taken? method
def position_taken?(board, position)
  position = position.to_i
  !(board[position].nil? || board[position] == " ")
end

# valid_move? method
def valid_move?(board, position)
    position = position.to_i - 1
    if !(position_taken?(board, position)) == true && position.to_i.between?(0, 8)
       true
    else
       false
    end
end

#turn method
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, "#{current_player(board)}")
  else
    puts "Please enter 1-9:"
    position = gets.strip
  end
  display_board(board)
end

#turn_count method
def turn_count(board)
  counter = 0
  board.each do |x|
  counter +=1 if x == "X" || x == "O"
  end
  counter
end

#current_player method
def current_player(board)
    if turn_count(board).even?
        return "X"
    else
        return "O"
    end
end

#won? method
def won?(board)
    answer = case
    when ( board[WIN_COMBINATIONS[0][0]] == "X" && board[WIN_COMBINATIONS[0][1]] == "X" && board[WIN_COMBINATIONS[0][2]] == "X" ) || ( board[WIN_COMBINATIONS[0][0]] == "O" && board[WIN_COMBINATIONS[0][1]] == "O" && board[WIN_COMBINATIONS[0][2]] == "O" )
    return WIN_COMBINATIONS[0]

    when ( board[WIN_COMBINATIONS[1][0]] == "X" && board[WIN_COMBINATIONS[1][1]] == "X" && board[WIN_COMBINATIONS[1][2]] == "X" ) || ( board[WIN_COMBINATIONS[1][0]] == "O" && board[WIN_COMBINATIONS[1][1]] == "O" && board[WIN_COMBINATIONS[1][2]] == "O" )
    return WIN_COMBINATIONS[1]

    when ( board[WIN_COMBINATIONS[2][0]] == "X" && board[WIN_COMBINATIONS[2][1]] == "X" && board[WIN_COMBINATIONS[2][2]] == "X" ) || ( board[WIN_COMBINATIONS[2][0]] == "O" && board[WIN_COMBINATIONS[2][1]] == "O" && board[WIN_COMBINATIONS[2][2]] == "O" )
    return WIN_COMBINATIONS[2]

    when ( board[WIN_COMBINATIONS[3][0]] == "X" && board[WIN_COMBINATIONS[3][1]] == "X" && board[WIN_COMBINATIONS[3][2]] == "X" ) || ( board[WIN_COMBINATIONS[3][0]] == "O" && board[WIN_COMBINATIONS[3][1]] == "O" && board[WIN_COMBINATIONS[3][2]] == "O" )
    return WIN_COMBINATIONS[3]

    when ( board[WIN_COMBINATIONS[4][0]] == "X" && board[WIN_COMBINATIONS[4][1]] == "X" && board[WIN_COMBINATIONS[4][2]] == "X" ) || ( board[WIN_COMBINATIONS[4][0]] == "O" && board[WIN_COMBINATIONS[4][1]] == "O" && board[WIN_COMBINATIONS[4][2]] == "O" )
    return WIN_COMBINATIONS[4]

    when ( board[WIN_COMBINATIONS[5][0]] == "X" && board[WIN_COMBINATIONS[5][1]] == "X" && board[WIN_COMBINATIONS[5][2]] == "X" ) || ( board[WIN_COMBINATIONS[5][0]] == "O" && board[WIN_COMBINATIONS[5][1]] == "O" && board[WIN_COMBINATIONS[5][2]] == "O" )
    return WIN_COMBINATIONS[5]

    when ( board[WIN_COMBINATIONS[6][0]] == "X" && board[WIN_COMBINATIONS[6][1]] == "X" && board[WIN_COMBINATIONS[6][2]] == "X" ) || ( board[WIN_COMBINATIONS[6][0]] == "O" && board[WIN_COMBINATIONS[6][1]] == "O" && board[WIN_COMBINATIONS[6][2]] == "O" )
    return WIN_COMBINATIONS[6]

    when ( board[WIN_COMBINATIONS[7][0]] == "X" && board[WIN_COMBINATIONS[7][1]] == "X" && board[WIN_COMBINATIONS[7][2]] == "X" ) || ( board[WIN_COMBINATIONS[7][0]] == "O" && board[WIN_COMBINATIONS[7][1]] == "O" && board[WIN_COMBINATIONS[7][2]] == "O" )
    return WIN_COMBINATIONS[7]

    end
end


#full? method
def full?(board)
  if board.include?(" ")
    false
  else
   true
  end
end

#draw? method
def draw?(board)
  if won?(board) == nil && full?(board)
    return true
  else
    return false
  end
end

#over? method
def over?(board)
   answer = case
   when full?(board) == false
    return false
   when draw?(board) || won?(board)
    return true
  end
end

#winner method
def winner(board)
  if won?(board) !=nil
  a = won?(board)
  b = board[a.first]
  return b
  else
  return nil
  end
end

#Play method
def play(board)
  until over?(board) == true || won?(board) do
    turn(board)
    if won?(board)
        break
    elsif draw?(board) == true
        break
    end
  end
  if winner(board)
  puts "Congratulations #{winner(board)}!"

  else
    puts "Cats Game!"
  end
end

