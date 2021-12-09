require 'set'
class Puzzle

  def self.parse(file)
    maze = File.readlines(file, chomp: true).map { |line| line.split('').map(&:to_i) }
    new(maze)
  end

  attr_reader :maze

  def initialize(maze)
    @maze = maze
    @max_x = maze.size
    @max_y = maze[0].size
  end

  def solve_pt1
    risk_sum = 0

    @maze.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        if neighbors_pt1(x,y).all? { |n| cell < n }
          risk_sum += cell + 1
        end
      end
    end

    risk_sum
  end

  def solve_pt2

    basins = []
    zeros = []

    @maze.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        if cell == 0
          zeros << [x,y]
        end
      end
    end

    zeros.each do |x,y|
      basin = bfs(x,y)
      basins << basin.size
    end

    basins.sort.reverse.take(3)
  end

  def bfs(x,y)
    visited = Set[]
    queue = []
    visited.add([x,y])
    queue << [x,y]

    while queue.any?
      x, y = queue.shift
      neighbors = neighbors_pt2(x,y)
      neighbors.each do |x,y|
        if !visited.include?([x,y])
          visited.add([x,y])
          queue << [x,y]
        end
      end
    end
    visited
  end

  def neighbors_pt1(x, y)
    [
      [x-1, y],
      [x+1, y],
      [x, y-1],
      [x, y+1]
    ].
    select { |x, y| x >= 0 && x < @max_x && y >= 0 && y < @max_y }.
    map { |x, y| @maze[x][y] }
  end

  def neighbors_pt2(x, y)
    [
      [x-1, y],
      [x+1, y],
      [x, y-1],
      [x, y+1]
    ].
    select { |x, y| x >= 0 && x < @max_x && y >= 0 && y < @max_y && @maze[x][y] < 9 }
  end

end