WIN_COMBINATIONS = [
  [0, 1, 2],  
  [3, 4, 5],  
  [6, 7, 8],  
  [0, 3, 6],  
  [1, 4, 7],  
  [2, 5, 8],  
  [2, 4, 6],  
  [0, 4, 8],  
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, input, char="X")
  location = (input.to_i - 1)
  board[location] = char
end


def position_taken?(board, input)
  sq = board[input]
  (sq == " " || sq == "" || sq == nil) ? (false) : (true)
end


def valid_move?(board, input)
  move = (input.to_i - 1)
  if move >= 0 && move <= 8
    position_taken?(board, move) ? false : true
  else
    false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    char = current_player(board)
    move(board, input, char)
  else
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
  count = 0
  board.each { |sq| count += 1 unless sq == " " || sq == "" || sq == nil }
  count
end


def current_player(board)
  turns = turn_count(board)
  turns % 2 == 0 ? "X" : "O"
end


def won?(board)
  winner = []
  check_win = -> xs_or_os do
    (winner = xs_or_os; break) if xs_or_os.size == 3 
  end
  
  WIN_COMBINATIONS.each do |combo|
    xs = []
    os = []
    combo.each do |windex|
      position = board[windex]
      case position
      when "X"
        xs << windex
      when "O"
        os << windex
      end 
      check_win.call(xs)
      check_win.call(os)
    end
  end
  (winner.empty?) ? false : winner 
end


def full?(board)
  empties = [" ", "", nil]
  full_board = true
  empties.each { |empty| (full_board = false; break) if board.include?(empty) }
  full_board
end


def draw?(board)
  if won?(board) != false
    false
  elsif full?(board) == false
    false
  else
    true
  end  
end


def over?(board)
  if draw?(board) == true
    true
  elsif won?(board) != false
    true
  elsif full?(board) == false
    false
  end
end


def winner(board)
  if won?(board) == false
    nil
  else
    winning_combo = won?(board)
    winning_square = winning_combo[0]
    (board[winning_square] == "X") ? "X" : "O"
  end
end


def play(board)
  until over?(board) == true
    turn(board)
  end
  
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
    puts "YOu have won!"
  else
    puts "Cats Game!"
  end
end

