## Helper Method
#def position_taken?(board, location)
#  !(board[location].nil? || board[location] == " ")
#end
#
## Define your WIN_COMBINATIONS constant
#
#WIN_COMBINATIONS= [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
#
#def won?(board)
#WIN_COMBINATIONS.detect do |arr| 
#  if board[arr[0]] == "X" && board[arr[1]] == "X" && board[arr[2]] == "X"
#    arr
#  elsif board[arr[0]] == "O" && board[arr[1]] == "O" && board[arr[2]] == "O"
#    arr
#  else
#    false
#  end
#end 
#end
#
#def full?(board)
#  !board.include?(" ") && !board.include?("")
#end
#
#def draw?(board)
#  if !won?(board) && full?(board)
#    true
#  elsif !won?(board) && !full?(board)
#    false
#  else won?(board)
#    false
#  end
#end 
#
#def over?(board)
#  if won?(board) || full?(board) || draw?(board)
#    true
#  else
#    false
#  end
#end
#
#def winner(board)
# if answer = won?(board)
#  board[answer.first]
# else
#  nil
# end
#end
# Helper Method
def position_taken?(board, location)
    !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2],[3,4,5],[6,7,8],
[0,3,6],[1,4,7],[2,5,8],
[0,4,8],[2,4,6]
]

def positions_filled(board)
    locations = [0,1,2,3,4,5,6,7,8]
    locations.select do |location|
        position_taken?(board, location)
    end
end

def won?(board)
    if board.all?{|x| x == " "}
        return false
    end
    status = WIN_COMBINATIONS.select do |combo|
        (position_taken?(board,combo[0]) && position_taken?(board,combo[1]) && position_taken?(board,combo[2])) && (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]])
    end
    if !status.empty?
        return status[0]
    end
end

def full?(board)
    board.none? {|position| position == " "}
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
    full?(board) || won?(board) || draw?(board)
end

def winner(board)
    won?(board) ? board[won?(board)[0]] : nil
end