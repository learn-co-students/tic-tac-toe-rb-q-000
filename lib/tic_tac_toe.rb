WIN_COMBINATIONS = [[0, 1, 2],
                    [3, 4, 5],
                    [6, 7, 8],
                    [0, 3, 6],
                    [1, 4, 7],
                    [2, 5, 8],
                    [0, 4, 8],
                    [6, 4, 2]]
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def move(board, position, player='X')
  board[position.to_i - 1] = player
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def valid_move?(board, position)
  if (position.to_i < 1 || position.to_i > 9)
    return false
  end
  return !position_taken?(board, position.to_i - 1)
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def position_taken?(board, position)
  if (board[position] == 'X' || board[position] == 'O')
    return true
  end
  return false
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def turn_count(board)
  count = 0
  board.each do |brd|
    if brd == 'X' || brd == 'O'
      count +=  1
    end
  end
  return count
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def current_player(board)
  if turn_count(board) == 0 || turn_count(board) % 2 == 0
    return 'X'
  end
  return 'O'
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def turn(board)
 loop do
    puts 'Please enter 1-9:'
    input = gets.strip
    if valid_move?(board, input)
      move(board, input, current_player(board))
      display_board(board)
      break
    end
  end
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def won?(board)
  WIN_COMBINATIONS.each do |win|
    if ((board[win[0]] == 'X' &&
         board[win[1]] == 'X' &&
         board[win[2]] == 'X') || (board[win[0]] == 'O' &&
                                   board[win[1]] == 'O' &&
                                   board[win[2]] == 'O'))
      return win
    end
  end
  return false
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def full?(board)
  board.each do |pos|
      if !(pos == 'X' || pos == 'O')
        return false
      end
  end
  return true
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  return false
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
  return
end
#||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts 'Cats Game!'
  else
    puts 'Game Over! Nobody won.'
  end
end