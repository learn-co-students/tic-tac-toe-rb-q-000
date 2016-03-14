WIN_COMBINATIONS = [
  [0, 1, 2], 
  [3, 4, 5], 
  [6, 7, 8], 
  [0, 3, 6], 
  [1, 4, 7], 
  [2, 5, 8], 
  [0, 4, 8], 
  [2, 4, 6]
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, position, character = "X")
  board[position.to_i-1] = character
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


def valid_move?(board, position)
  position.to_i.between?(1, 9) && !position_taken?(board, position.to_i - 1)
end


def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  character = current_player(board)

  until valid_move?(board, position) == true
    puts "Sorry, that's not a valid move."
    puts "Please enter 1-9 again:"
    position = gets.strip
  end

  move(board, position, character)

  display_board(board)
end


def turn_count(board)
  count = 0

  board.each do |turn|
    if turn == "X" || turn == "O"
      count += 1
    end
  end
  return count
end


def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.each do |win_array|
    position_1 = board[win_array[0]]
    position_2 = board[win_array[1]]
    position_3 = board[win_array[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O" 
      return win_array
    end
  end
  false
end


def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end


def draw?(board)
  if !(won?(board)) && full?(board)
    return true
  elsif won?(board) && full?(board) || !(won?(board) && full?(board))
    return false
  end
end


def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end


def winner(board)
  if won?(board)
    token = won?(board)[0]

    return board[token]
  end
end


def play(board)

  # until the game is over
  until over?(board)
    # take turns
    turn(board)

  # end
  end
 
  # if the game was won
  if won?(board)
    #  congratulate the winner
    puts "Congratulations #{winner(board)}!"
  # else if the game was a draw
  else
    #   tell the players it has been a draw
    puts "Cats Game!"
  # end
  end

  
end


































