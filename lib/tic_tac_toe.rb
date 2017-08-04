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
  if(valid_move?(board, index) == true)
   board[index] = current_player
 end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |b|
    (b == "X" || b == "O") ? counter += 1 : counter += 0
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def confirm_token_match(board, token = "X")
  WIN_COMBINATIONS.detect do |win_combos|
    win_combos.all? do |check_pos|
      position_taken?(board, check_pos) == true && board[check_pos] == token
    end
  end
end

def won?(board)

  winning_array = confirm_token_match(board)
  winning_array.is_a?( Array ) ? winning_array : winning_array = confirm_token_match(board, "O")
  winning_array.is_a?( Array ) ? winning_array : nil

end

def full?(board)
  board.all? { |element| element == "X" || element == "O" }
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def winner(board)
  if(won?(board))
    winning_input = confirm_token_match(board)
    winning_input.is_a?( Array ) ? "X" : "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input.to_i
    if(input.between?(1,9))
      index = input_to_index(input)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
end

def play(board)

  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  end
  if(draw?(board))
    puts "Cats Game!"
  end
  until(over?(board))
    turn(board)
    if (won?(board))
      puts "Congratulations #{winner(board)}!"
    end
    if(draw?(board))
      puts "Cats Game!"
    end
  end
end
