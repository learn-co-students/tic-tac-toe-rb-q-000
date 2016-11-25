WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [1, 4, 7], [2, 4, 6], [0, 3, 6], [2, 5, 8]]

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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  current_player = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == false
    turn(board)
  elsif valid_move?(board, index) == true
  end
    move(board, index, current_player)
    display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |el|
    counter += 1 unless el == " "
  end
  counter
end

def current_player(board)
 counter = turn_count(board)
  if counter % 2 == 0
    current_player = "X"
  else current_player = "O"
  end
current_player
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    winner = []
    win_combination.each do |win_index|
      winner << board[win_index]
        end
          if winner[0] == winner[1] && winner[0] == winner[2] && winner[0] != " "
            return win_combination
            return true
            break
          end
        end
  false
end

def full?(board)
  if board.all? {|el| el == "X" || el == "O"}
    return true
  else false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
 end

def over?(board)
  if full?(board)
    return true
  else false
  end
end

def winner(board)
  if !won?(board)
  return nil
  else
  board[won?(board)[0]]
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def play(board)
  idx = 0
  until over?(board) == true || won?(board) != false || draw?(board) == true
    turn(board)
    idx += 1
  end
  if won?(board) != false
  puts "Congratulations #{winner(board)[0]}!"
  elsif draw?(board)
  puts "Cats Game!"
  end
end
