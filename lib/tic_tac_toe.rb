WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
    ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location) # the test for third parameter in spec file one doesn't seem compatable with using "current_player" in this method.
  board[location.to_i-1] = current_player(board)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
    count = 0
    board.each do |play|
        if (play == 'X') || (play == 'O')
            count += 1
        end
    end
    count
end

def current_player(board)
    if turn_count(board) % 2 == 0
        'X'
    else
        'O'
    end
end

def won?(board) # is a mess.  refactor.
    array_of_diagonals = []
    won = false
    win_combination = false
    WIN_COMBINATIONS.each do |winning|
        array_of_diagonals = [ board[winning[0]], board[winning[1]], board[winning[2]]]
        won = array_of_diagonals.all? {|f| f == 'O'}
        if won == false
            won = array_of_diagonals.all? {|f| f == 'X'}
        end
        if won == true
            win_combination = winning
        end
        break if won == true
    end
    win_combination
end

def full?(board)
    board.all? {|f| /[OX]/.match(f)}
end

def draw?(board)
    full?(board) && !won?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
    if won?(board)
        board[won?(board)[1]]
    else
        nil
    end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
  puts "Cats Game!"
  end  
end