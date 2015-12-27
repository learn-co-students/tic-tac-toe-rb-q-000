
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # first column
  [1,4,7], # second column
  [2,5,8], # third column
  [0,4,8], # diagonal left
  [2,4,6] # diagonal right
]

def play(board)

until over?(board)
       turn(board)
end

        if winner(board) == "X"
        puts "Congratulations X!"
        elsif winner(board) == "O"
        puts "Congratulations O!"
        elsif draw?(board)
        puts "Cats Game!"
        end
end

def display_board(board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end



def turn_count(board)

        counter = 0
        board.each do |occupied|

                if occupied == "X" || occupied == "O"
                        counter += 1
                end # ends if statement
        end # ends do
        counter
end # ends method

def current_player(board)

        if turn_count(board).odd?
                return "O"
        elsif turn_count(board).even?
                return "X"
        end
end

def move(board, position, character = "X")

        if character == "X" || character == "O"
               board[position.to_i-1] = character
       elsif current_player(board) == "X"
                board[position.to_i-1] = "X"
        elsif current_player(board) == "O"
                board[position.to_i-1] = "O"
        end

  return board
end

def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end

def valid_move?(board, position)

        position = position.to_i-1

        if position >= 0 && position <= 8 && board[position] == " "
                return true

        else position_taken?(board, position) != false
                return false
        end
end


def full?(board)
        board.all?{|full| full == "X" || full == "O"}
        end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]] &&
    position_taken?(board, win_combination[0])
  end
end

def draw?(board)

        !won?(board) && full?(board)

end

def over?(board)

        draw?(board) || won?(board)

end

def winner(board)

     if   winning_combination = won?(board)
    board[winning_combination.first]
     end
end

def turn(board)
        puts "Please enter 1-9:"
        position = gets.strip

        if valid_move?(board, position)
                move(board, position,current_player(board))
               display_board(board)

        else !valid_move?(board, position)
                puts "The move is invalid. Please enter a move again:"
                turn(board)
        end
end

