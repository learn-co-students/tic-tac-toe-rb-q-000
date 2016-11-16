WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

board = [ " ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end




def input_to_index(input)
  input.to_i - 1
end

def move(board, input, value)
  board[input.to_i] = value
end



def position_taken?(board, input)
  board[input] != " "
end


def valid_move?(board, input)
  !position_taken?(board, input) && input.to_i.between?(0, 8)
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

def turn_count(board)
  numturns = 0
  board.each do |position|
    if position != " "
      numturns += 1
    end
  end
  numturns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|

      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

         if position_1 == "X" && position_2 == "X" && position_3 == "X"
           return win_combination
         elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
           return win_combination
         else
           false
        end
    end
    false
end

def full?(board)
  board.all? {|position| position != " "}
end

def draw?(board)
  if full?(board) == false
    false
  elsif won?(board) == false
    true
  else
    false
  end
end

def over?(board)
  if won?(board)
    true
  elsif draw?(board)
    true
  else
    false
  end
end

def winner(board)
  won?(board)

      WIN_COMBINATIONS.each do |win_combination|

          win_index_1 = win_combination[0]
          win_index_2 = win_combination[1]
          win_index_3 = win_combination[2]

          position_1 = board[win_index_1]
          position_2 = board[win_index_2]
          position_3 = board[win_index_3]

             if position_1 == "X" && position_2 == "X" && position_3 == "X"
               return "X"
             elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
               return "O"
             end
           end
          else nil
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
