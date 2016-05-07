#run tests for methods by typing rspec spec/01_tic_tac_toe_spec.rb
#helper methods go here

WIN_COMBINATIONS =
  [
  [0,1,2], #top row
  [3,4,5], #mid row
  [6,7,8], #bottom row
  [0,4,8], #right diag
  [2,4,6], #left diag
  [0,3,6], #left column
  [1,4,7], #mid column
  [2,5,8] #right col
  ]

  def display_board(board)
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def move(board, position, character )
    position.to_i
    position = position - 1
    board[position] = character
    puts "#{board}"
  end

  def position_taken?(board, position)
    if board[position] == " " || board[position] == "" || board[position] == nil
      return false
    else board[position] == "X" || board[position] == "O"
      return true
    end
  end

  def valid_move?(board, position)
    #binding.pry
      if position.to_i.between?(1, 9)
        postionvar = position.to_i - 1
          if position_taken?(board, postionvar) == false
            return true
          else position_taken?(board, postionvar) == true
            return nil
          end
      else
        return false
    end

  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    location = input.to_i
    if valid_move?(board, location)
      move(board, location, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def turn_count(board)
    counter = 0
      board.each do |boardxy|
        if boardxy == "X" || board[counter] == "O"
          counter += 1
        end
      end
    return counter
  end

  def current_player(argument)
    if turn_count(argument) % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?(board)
    WIN_COMBINATIONS.detect do |win1|
      win1.all? { |number| board[number] == "X"} || win1.all? { |number| board[number] == "O"}
      end
    end

  def full?(board)
    #board.all? {|i| i == "X"} || == "O"}
    !board.any? {|i| i == " "}
  end
  #true if board not won & full,
  #false if board not won and not full
  #false if board is won
  def draw?(board)
    if !won?(board) && full?(board)
      return true
    else
      return false
    end
  end
  #true if won, draw or full.
  def over?(board)
    if won?(board) || draw?(board) || full?(board)
      return true
    end
  end

  def winner(board)
    if won?(board)
      won?(board).each do |each|
        return board[each]
      end
    end
  end

  def play(board)
    count = 1
    while count < 9
      turn(board)
      count += 1
    end
  end
