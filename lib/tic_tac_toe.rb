WIN_COMBINATIONS = [
    # Rows combinations
    [0,1,2],
    [3,4,5],
    [6,7,8],
    # Columns combinations
    [0,3,6],
    [1,4,7],
    [2,5,8],
    # Diagonals combinations
    [0,4,8],
    [2,4,6]
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
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def turn_count(board)
    counter = 0
    board.each do | position |
        if position == "X" || position == "O"
            counter += 1
        end
    end
    counter
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.each do |combo|
        # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
        # grab each index from the win_combination that composes a win
        if board[combo[0]] != " " && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
            return combo
        end
    end
    false
end

def full?(board)
    board.all? do |move|
        move == "X" || move =="O"
    end
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
    draw?(board) || full?(board) || won?(board) != false
end

def winner(board)
    if win = won?(board)
        board[win.first]
    end
end
