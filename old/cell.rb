class Cell
  attr_reader :number, :index, :row, :column, :sub_grid, :hints

  def initialize(number, index)
    @number = number.to_i
    @hints = []
    @pairs = []
    find_indices(index)
  end

  def empty?
    number.zero?
  end

  def solved?
    !empty?
  end

  def solve(number)
    @number = number
    @hints = []
  end

  def remove_hints(numbers)
    @hints -= Array(numbers)
  end

  private

  def find_indices(index)
    @index = index
    @row = index / 9
    @column = index % 9
    @sub_grid = ((row / 3) * 3) + (column / 3)
  end
end