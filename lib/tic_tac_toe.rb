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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def move(board, index, current_player)
  board[index] = current_player
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

# Define your play method below

def play(board)
  counter = 0
  while counter < 9
    turn(board)
    counter += 1
  end
end


def turn_count(board)

  counter = 0

  board.each do |turn|
    if turn == "X" || turn == "O"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    current_player = "X"
  else current_player = "O"
  end
  current_player
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [

    [0,1,2], #top row
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
]

def won?(board)

  win_combo = true

  WIN_COMBINATIONS.each do |win_combination|

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
       return win_combination.to_ary
     else
       win_combo = false
     end
   end
   return win_combo
end


def full?(board)

    board.all? do |cells|
      if cells == "X" || cells == "O"
        true
      else
        false
      end
    end
end

def draw?(board)
  if ((full?(board) == true) && (won?(board) == false))
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)

  if !(won?(board))
    return nil
  elsif board[won?(board)[0]] == "X"
    $winn = "X"
    return "X"
  else board[won?(board)[0]] == "O"
    $winn = "O"
    return "O"
  end
end


def play(board)

    while !over?(board)
      turn(board)
    end

    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else draw?(board)
      puts "Cat's Game!"
    end
end
