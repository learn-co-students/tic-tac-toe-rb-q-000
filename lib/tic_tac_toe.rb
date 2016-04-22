WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Backslash diagnol
  [2,4,6]   # Slash diagnol
]

def display_board(board)
  # puts "Inside #{__callee__}"
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def show_square_numbers
    board = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "

    board = [ " ", " ", " ", " ", " ", " ", " ", " ", " " ]
end

def position_taken?(board, location)
  # puts "Inside #{__callee__}"
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  # puts "Inside #{__callee__}"
    position = Integer(position) rescue nil
    position != nil && !position_taken?(board, position - 1)
end

def turn(board, char = "X")
  # puts "Inside #{__callee__}"
    begin
      input = gets.strip.to_i
    end until input.between?(1, 9)

    move(board, input, char)
    display_board(board)
end

def move(board, input, char = "X")
  # puts "Inside #{__callee__}"
    index = input.to_i
    index -= 1
    board[index] = char
end

def turn_count(board)
  # puts "Inside #{__callee__}"
    board.count { |space| space != " " }
end

def current_player(board)
  # puts "Inside #{__callee__}"
    tokens = ["X", "O"]
    tokens[turn_count(board) % 2]
end

def won?(board)
  # puts "Inside #{__callee__}"
  winning_line(board).size == 3
end

def winning_line(board)
  # puts "Inside #{__callee__}"
  line = []
  WIN_COMBINATIONS.each do |lines|
    if board[lines[0]] == board[lines[1]] && board[lines[0]] == board[lines[2]] && board[lines[0]] != " "
      line = lines
    end
  end

  line
end

def draw?(board)
  # puts "Inside #{__callee__}"
  board.none?{ |square| square == " " } && winning_line(board).eql?([])
end

def full?(board)
  # puts "Inside #{__callee__}"
  board.none?{ |square| square == " " }
end

def over?(board)
  # puts "Inside #{__callee__}"
  full?(board) || !winning_line(board).eql?([])
end

def winner(board)
  char = nil
  if winning_line(board).size == 3
    char = board[winning_line(board)[0]]
  end

  char
end

def play(board)
  # puts "Inside #{__callee__}"
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    return
  end

  if draw?(board)
    puts "Cats Game!"
    return
  end

  until over?(board) do
    turn(board, current_player(board))
    if won?(board)
      puts "Congratulations #{winner(board)}!"
      break
    end

    if draw?(board)
      puts "Cats Game!"
      break
    end
  end
end