WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[2, 5, 8],
[1, 4, 7],
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

def move(board, location, current_player = "X")
    board[location.to_i-1] = current_player
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
    if !valid_move?(board, input)
        turn(board)
    else
        move(board, input, current_player(board))
        display_board(board)
    end
end

def turn_count(board)
    counter = 0
    board.each do |space|
        if space == "X" || space == "O"
            counter += 1
            
        end
    end
    counter
end

def current_player(board)
    if turn_count(board) % 2 == 0
        return "X"
        else turn_count(board) % 2 == 1
        return "O"
    end
end

def won?(board)
    WIN_COMBINATIONS.detect do |combo|
        board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[2])
    end
end

def full?(board)
    board.all? do |taken|
        taken == "X" || taken == "O"
    end
end

def draw?(board)
    if won?(board).nil?  && full?(board) == true
        return true
      
        else won?(board) == false && full?(board) == false
        return false
    end
end

def over?(board)
    if won?(board) || draw?(board) || full?(board)
        return true
        else
        return false
    end
end

def winner(board)
    (pos = won?(board)) ? board[pos[0]] : nil
end

def play(board)
    until over?(board)
        turn(board)
    end
        if won?(board)
            puts "Congratulations #{winner(board)}!"
        else draw?(board)
            puts "Cats Game!"
        end
end

