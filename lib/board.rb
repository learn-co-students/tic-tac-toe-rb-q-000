class BoardMaker
  attr_accessor :matrix

  def initialize(board)
    @matrix = Hash[board.each_with_index.map { |v, i| [i,' ' + v + ' '] }]
  end

  def print_board
    print row1
    print horizontal_ruler
    print row2
    print horizontal_ruler
    print row3
  end
  
  private
  def horizontal_ruler
    "-----------"
  end

  def row1
    matrix[0] + '|' + matrix[1] + '|' + matrix[2]
  end

  def row2
    matrix[3] + '|' + matrix[4] + '|' + matrix[5]
  end

  def row3
    matrix[6] + '|' + matrix[7] + '|' + matrix[8]
  end
end

