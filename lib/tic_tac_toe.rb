   
   
  WIN_COMBINATIONS =[ 
     [0,1,2],#0 #top row horizontal
     [3,4,5],#1 #middle row horizontal
     [6,7,8],#2 #buttom row horizontal
     
     [0,3,6],#3 #left column vertical
     [1,4,7],#4 #middle column vertical
     [2,5,8],#5 #right column verical

     [8,4,0],#6 #left_to_right adj
     [2,4,6] #7 #right_to_left adj
  ]

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end



  #--//////// Game status //////--

  def won?(board)
    WIN_COMBINATIONS.find do |set|
      board[set[0]] == board[set[1]] &&
      board[set[1]] == board[set[2]] &&
      position_taken?(board, set[2])
    end
  end


  def full?(board)
    !(board.include?(" ") || board.include?(""))
  end

  def draw?(board)
   won?(board).nil? && full?(board)
  end

  def over?(board)
    full?(board) && draw?(board) || !(won?(board).nil?)
  end

  def winner(board)
    if won?(board) !=nil
     board[ won?(board)[0] ]
    else
      won?(board)
    end
  end

#--//////// Game progress //////--
  
  def turn(board)
    display_board(board)
    puts "Please enter 1-9:"
    location = gets.strip
      if valid_move?(board, location)
        move(board, location, current_player(board))
      else
        turn(board)
      end
  end

  def valid_move?(board, location)
    location.to_i.between?(1,9) && !(position_taken?(board, location.to_i-1) )
  end

  def position_taken?(board, location)
    board[location] != " " && 
    board[location] != ""  
  end

  def turn_count(board)
    board.count{|element| element=="X" || element=="O"}
  end

  def current_player(board)
    if turn_count(board).even? 
      return "X"
      else
      return "O"    
    end
  end

  def move(board, location, current_player)
    board[location.to_i-1] = current_player
  end

#--//////// Game initializer //////--

def play(board)
      until over?(board)== true || 
            draw?(board)!= false || 
            won?(board)!= nil
            turn(board)
        end

        if won?(board) !=nil 
              puts "Congratulations #{winner(board)}!"
              won?(board)
          else draw?(board)   
               display_board(board)
               puts "Cats Game!"
               draw?(board)  
        end
end







