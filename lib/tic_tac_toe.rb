# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[ 0, 1, 2],
[ 3, 4, 5],
[ 6, 7, 8],
[ 0, 3, 6],
[ 1, 4, 7],
[ 2, 5, 8],
[ 0, 4, 8],
[ 2, 4, 6],
]

# display_board
board = [" "," "," "," "," "," "," "," "," "]

def display_board(display)
    puts " #{display[0]} | #{display[1]} | #{display[2]} "
    puts "-----------"
    puts " #{display[3]} | #{display[4]} | #{display[5]} "
    puts "-----------"
    puts " #{display[6]} | #{display[7]} | #{display[8]} "
end

display_board(board)

#make a move
def move(board, input, n = "X")
    if valid_move?(board, input) && (n == "X" || n == "O")
        board[board_index(input)] = n
        return true
    else
        return false
    end
end

#valid_move
def valid_move?(board, position)
    index = board_index(position)
    value = board[index].strip
    input = position.to_i - 1
    if !position_taken?(board, input) && input.between?(0,8)
        return true
    else
        return false
    end
end

#convert position numbers into index numbers
def board_index(position)
    (position.to_i) - 1
end

#convert index numbers into position numbers
def board_position(index)
    (index.to_i) + 1
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, position)
    if board[position] == "" || board[position] == " " || board[position] == nil
        return false
    else
        return true
    end
end

#it's your turn: enter number from 1-9
def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    if !move(board, input)
        puts "Number is not valid"
        puts "Please enter 1-9:"
        input = gets.strip
        if !move(board, input)
            return puts "Please enter a valid number"
        end
    end
    display_board(board)
end

#turn_count
def turn_count(board)
    counter = 0
    board.each do |space|
        if  space == "X" || space == "O"
            counter += 1
        end
    end
    return counter
end

#current_player
def current_player(board)
    x_player = "X"
    o_player = "O"
    if turn_count(board) == 0
        return x_player
    elsif turn_count(board) % 2 == 0
        return x_player
    else
        return o_player
    end
end

#won?
def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]
        
        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]
        
        if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" &&position_2 == "O" && position_3 == "O"
            return win_combination
        end
    end
    return false
end

#full?
def full?(board)
    board.all? do |space|
        space == "X" || space == "O"
    end
end

#draw?
def draw?(board)
    if !won?(board) && full?(board)
        return true
    elsif !won?(board) && !full?(board)
        return false
    else won?(board)
        return false
    end
end

#over?
def over?(board)
    if won?(board) || draw?(board) || full?(board)
        return true
    else
        return false
    end
end

#winner
def winner(board)
    win_combination = won?(board)
    if win_combination
        board[win_combination[0]]
    end
end

# Define your play method below
def play(board)
    turn(board) until over?(board)
    puts "Cats Game!" if draw?(board)
    puts "Congratulations #{winner(board)}!" if won?(board)
end