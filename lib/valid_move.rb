# puts "Make your move"
# input = gets.strip
# position = input.to_i-1
  # code your #valid_move? method here
  def valid_move?(board, position)
    position = position.to_i-1
    puts position_taken?(board, position)
      if position_taken?(board, position)
          if position.between?(0, 8) == false
              return false
          end
      #else false, board space is open   
      else 
          if position.between?(0, 8) == true
            return true
            puts "valid move yes, true"

          end
      end
  end
 # re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
    def position_taken?(board, position)
      puts "board[#{position}]"
     if board[position] == "  " || board[position] == " " || board[position] == "" || board[position] == nil
        return false
     elsif board[position] == "X" || board[position] == "O"
        return true
      end
    end


   

# valid_move?(board, position)