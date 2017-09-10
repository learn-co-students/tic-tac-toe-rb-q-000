board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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

def turn_count(board)
  turns = board.select do |position|
    position == "X" || position == "O"
    end
  turns.length
end

def current_player(board)
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end

def move(board, index, player_token = current_player)
  board[index] = player_token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0 ,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? do |win_index|
      board[win_index] == "X"
    end
      return win_combination
    elsif win_combination.all? do |win_index|
      board[win_index] == "O"
    end
      return win_combination
    end
  end
  return false
  board.any? do |position|
    position == "X" || position == "O"
  end
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    win_combination = won?(board)
      if board[win_combination[0]] == "X"
        return "X"
      else
        return "O"
      end
  end
end
