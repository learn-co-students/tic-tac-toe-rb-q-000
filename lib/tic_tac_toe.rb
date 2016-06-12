WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #middle row
    [6,7,8], #bottom row
    [0,3,6], #left row
    [1,4,7], #middle row
    [2,5,8], #right row
    [0,4,8], #cross row
    [6,4,2] #cross row
  ]

    def play(board)
      until over?(board)
        turn(board) 
        if over?(board)
          if won?(board)
            puts "Congratulations #{winner(board)}!"
          elsif draw?(board)
            puts "Cats Game!"
          end
        end
      end
    end


  def display_board(xo)
    puts [" #{xo[0]} " + "|" + " #{xo[1]} " + "|" + " #{xo[2]} "]
    puts ["-----------"]
    puts [" #{xo[3]} " + "|" + " #{xo[4]} " + "|" + " #{xo[5]} "]
    puts ["-----------"]
    puts [" #{xo[6]} " + "|" + " #{xo[7]} " + "|" + " #{xo[8]} "]
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(board, index, xo)
    board[index] = xo
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
    if valid_move?(board, index) == true
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def turn_count(board)
    counter = 0
    board.each do |position|
      if position == "X" || position == "O"
        counter += 1
      end
    end
    return counter
  end

  def current_player(board)
      if turn_count(board).even?
        "X"
      else
        "O"
      end
  end

  def won?(board)
      WIN_COMBINATIONS.each do |position|
        if board[position[0]] == "X" && board[position[1]] == "X" && board[position[2]] == "X"
            return position
        elsif board[position[0]] == "O" && board[position[1]] == "O" && board[position[2]] == "O"
            return position
        end
      end
      false
  end


  def full?(board)
    !board.any?{|field| field == " "}
  end

  def draw?(board)
    !won?(board) && full?(board)
  end

  def over?(board)
    won?(board) || draw?(board) || full?(board)
  end

  def winner(board)
    WIN_COMBINATIONS.each do |position|
      if board[position[0]] == "X" && board[position[1]] == "X" && board[position[2]] == "X"
          return "X"
      elsif board[position[0]] == "O" && board[position[1]] == "O" && board[position[2]] == "O"
          return "O"
      end
    end
    nil
  end
