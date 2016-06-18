WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]]

def display_board (board)
       puts " #{board[0]} | #{board[1]} | #{board[2]} "
       puts "-----------"
       puts " #{board[3]} | #{board[4]} | #{board[5]} "
       puts "-----------"
       puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
    return index
   end

   def move(board, input, character)
     board[input] = character
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
       move(board, index, current_player(board))
       display_board(board)
     else
      turn(board)
     end
   end


   def turn_count(board)
     count = 0
     for i in 0..8
       if position_taken?(board, i)
         count +=1
       end
     end
     return count
   end


   def current_player(board)
       turn_count = turn_count(board)
   if turn_count % 2==0
     return "X"
   else
     return "O"
   end
   end

   def won?(board)
     for i in 0..7
       if (board[WIN_COMBINATIONS[i][0]]==board[WIN_COMBINATIONS[i][1]]) && (board[WIN_COMBINATIONS[i][1]]==board[WIN_COMBINATIONS[i][2]]) && (board[WIN_COMBINATIONS[i][0]]!= "" && board[WIN_COMBINATIONS[i][0]]!=" ")
         return WIN_COMBINATIONS[i]
       end
     end
     return nil
   end

   def full?(board)
     for i in 0..8
       if !position_taken?(board, i)
         return false
       end
     end
       return true
   end

   def draw?(board)
     if  won?(board)==nil && full?(board)
       return true
     else
       return false
     end
   end

   def over?(board)
     if won?(board)!=nil || full?(board) || draw?(board)
       return true
     else
       return false
     end
   end

   def winner(board)
     if won?(board) != nil
     return board[won?(board)[0]]
   else
     return nil
   end
   end

   def play(board)
     until over?(board) do
       turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
   end
