 WIN_COMBINATIONS = [
    [0,1,2],
    [0,3,6],
    [0,4,8],
    [1,4,7],
    [2,5,8],
    [3,4,5],
    [6,7,8],
    [6,4,2]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


  def move(board, location, player = "X")
    board[location.to_i - 1] = player
  end

  def position_taken?(board, position)
    if !(board[position].nil? || board[position] == " " || board[position] == "")
      true
    else
      false
    end
  end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


 def turn_count(board)
   count = 0
   board.each { |position|  if position == "X" || position == "O"
     count += 1
     end
     }
   count
end




def current_player(board)

  if turn_count(board) % 2 == 0

    "X"

  else

  "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index = win_combination
          position_1 = board[win_index[0]]
          position_2 = board[win_index[1]]
          position_3 = board[win_index[2]]



    if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
      elsif   position_1 == "O" && position_2 == "O" && position_3 == "O"
          return win_combination
      end

  end
  if board ==  [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      false
    end

end


  def full?(board)

  board.all?{|i|
      i == "X" || i == "O"

    }
  end

  def draw?(board)

    full?(board) && !won?(board)

  end

  def over?(board)

      draw?(board) || won?(board)

  end

  def winner(board)

    WIN_COMBINATIONS.each do |win_combo|
      if win_combo.all? {|index| board[index] == "X" }
         return "X"
      elsif win_combo.all? {|index| board[index] == "O"}
         return  "O"
      end
      end
      nil
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