WIN_COMBINATIONS = [
    [0, 1, 2], #top row
    [3, 4, 5], #middle row
    [6, 7, 8], #bottom row
    [0, 3, 6], #left col
    [1, 4, 7], #middle col
    [2, 5, 8], #right col
    [0, 4, 8], #diagnol l to r
    [2, 4, 6] #diagnol r to l
] 
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(move)
    move = move.to_i - 1
end 

def move(board, move, choice)
    move = move.to_i
    board[move] = choice
end

def position_taken?(board, pos)
  #true if position taken, false if open
  pos = pos.to_i
  if board[pos] == " " or board[pos] == "" or board[pos] == nil
    false
  else
    true
  end
end 

def valid_move?(board, pos)
  pos = pos.to_i    
  if position_taken?(board, pos) == false and pos.between?(0, 9)
      true
  else
    false
  end     
end

def turn(board)
  puts "Please enter 1-9:"
  loc = gets.chomp
  loc = input_to_index(loc)
  if valid_move?(board, loc) == false
    puts "Invaild input"
    turn(board)
  end
  move(board, loc, choice = current_player(board))
  display_board(board)
end

def turn_count(board)
    count = 0
    board.each do |choice|
        if choice == 'X' or choice == 'O'
            count += 1
        end
    end
    count
end


def current_player(board)
    player = turn_count(board)
    player % 2 == 0 ? 'X' : 'O'
end

def won?(board)
    WIN_COMBINATIONS.each do |combo|
        list = board[combo[0]], board[combo[1]], board[combo[2]]
        if list.all? {|choice| choice == 'X'} or list.all? {|choice| choice == 'O'}
            return combo
        end
    end
    false
end

def full?(board)
    if board.any? {|choice| choice == " "}
        return false
    end
    return true
end

def draw?(board)
    won?(board)
    if full?(board) and not won?(board)
        return true
    end
    return false
end
        
def over?(board)
    if draw?(board) or won?(board)
        return true
    end
    return false
end

def winner(board)
    if won?(board)
        winner = won?(board)[0]
    return board[winner]
    end
end


def play(board)
    while not over?(board)
        current_player(board)
        turn(board)
        turn_count(board)
    end
    if winner(board) == 'X'
        puts "Congratulations X!"
    elsif winner(board) == 'O'
        puts "Congratulations O!"
    end

    if draw?(board)
        puts 'Cats Game!'
    end
        
end












