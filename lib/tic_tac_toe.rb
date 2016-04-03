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

def valid_move?(board, position)
  position.to_i.between?(1, 9) && !(position_taken?(board, position.to_i-1))
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def move(board, position, token="X")
  board[position.to_i-1] = token
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp

  if valid_move?(board, input)
    
    def turn_count(board)
      counter = 0
      board.each do |space|
        if space != " "
          counter += 1
        end
      end
      counter
    end

    def current_player(board)
      turn_count(board)%2==0? "X" : "O"
    end

    move(board, input, current_player(board))
    display_board(board)

  else
    turn(board)

  end
end






def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] ==board[win_combination[2]] && position_taken?(board, win_combination[0])

  end
end

def full?(board)
  board.all? {|i| i!=" "}
end 

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
    if win_combination = won?(board)
      board[win_combination.first]
    end
end

def play(board)
  turn(board) until over?(board)

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end