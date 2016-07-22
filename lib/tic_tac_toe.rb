def play(board)
  until won?(board)!=nil || draw?(board)!=nil
    turn(board)
    puts "board after turnis"
    display_board(board)
  end
  if won?(board)==true
    if winner(board)=="X"
      puts "Congratulations X!"
    end
    if winner(board)=="O"
      puts "Congragulations O!"
    end
  else
    puts "no winner yet"
    turn(board)
  end
end


WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def input_to_index(input)
  input2=input.to_i
  index=input2-1
  return index
end
def move(board, index, token)
  board[index]=token
  board
end
def position_taken?(board, index)
  if board[index]==" "
    false
  elsif board[index]==""
    false
  elsif board[index]==nil
    false
  else
    true
  end
end
def valid_move?(board, index)
  if position_taken?(board, index)
    false
  elsif [0,1,2,3,4,5,6,7,8].include? index
    true
  else
    false
  end
end
def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  index=false
  while index==false
    index=prompt(board)
  end
  if valid_move?(board,index)==true
    token=current_player(board)
    move(board, index, token)
  end
  board
end
def prompt(board)
  index=false
  puts "What is your move?"
  input=gets.strip
  puts "you chose #{input}"
  index=input_to_index(input)
  if index==-1
    index=false
  end
  return index
end
def turn_count(board)
  count=0
  board.each do |spot|
    if spot=="X" || spot=="O"
      count+=1
    end
  end
  count
end
def current_player(board)
  cur=nil
  if turn_count(board).even?
    cur="X"
  end
  if turn_count(board).odd?
    cur="O"
  end
  cur
end
def won?(board)
  won=nil
  WIN_COMBINATIONS.each do |winco|
    if board[winco[0]]==board[winco[1]] && board[winco[1]]==board[winco[2]] && board[winco[2]]!=" " && board[winco[2]]!=""
      won= winco
    end
  end
  won
end
def full?(board)
  full=nil
  full=[0,1,2,3,4,5,6,7,8].all? do |spot|
    position_taken?(board, spot)
  end
  full
end
def draw?(board)
  draw=nil
  if won?(board)==nil && full?(board)==true
    draw=true
  end
  draw
end
def over?(board)
  over=nil
  if full?(board)==true || won?(board)==true
    over=true
  end
end
def winner(board)
  winner=nil
  WIN_COMBINATIONS.each do |winco|
    if board[winco[0]]==board[winco[1]] && board[winco[1]]==board[winco[2]] && board[winco[2]]!=" " && board[winco[2]]!=""
      winner=board[winco[0]]
    end
  end
  winner
end
