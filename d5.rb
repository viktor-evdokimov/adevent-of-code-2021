class Puzzle

  class Line
    attr_reader :start, :finish, :coordinates

    def initialize(start, finish)
      @start = start.split(',').map(&:to_i)
      @finish = finish.split(',').map(&:to_i)
      @coordinates = find_coordinates
    end

    def vertical?
      start[0] == finish[0]
    end

    def horizontal?
      start[1] == finish[1]
    end

    def vertical_or_horizontal?
      vertical? || horizontal?
    end

    def range(a, b)
      min, max = [a,b].sort
      if (a > b)
        (min..max).to_a
      else
        (min..max).to_a.reverse
      end
    end

    def find_coordinates
      if vertical?
        range(start[1],finish[1]).map { |y| [start[0], y] }
      elsif horizontal?
        range(start[0],finish[0]).map { |x| [x, start[1]] }
      else
        range(start[0],finish[0]).zip(range(start[1],finish[1]))
      end
    end
  end

  attr_reader :input, :max_x, :max_y, :scores, :only_vertical_or_horizontal

  def self.parse(file, max_x, max_y, only_vertical_or_horizontal=true)
    @input = File.readlines(file, chomp:true).map {|line| line.split('->') }.map { |i| Line.new(i[0], i[1]) }
    new(@input, max_x, max_y, only_vertical_or_horizontal)
  end

  def initialize(input, max_x, max_y, only_vertical_or_horizontal=true)
    @input = input
    @max_x = max_x
    @max_y = max_y
    @scores = max_x.times.map { |x| max_y.times.map { |y| 0 } }
    @only_vertical_or_horizontal = only_vertical_or_horizontal
  end

  def find_scores
    input.each do |line|
     if only_vertical_or_horizontal && !line.vertical_or_horizontal?
       next
     end
      coordinates = line.coordinates
      coordinates.each do |x, y|
        scores[x][y] += 1
      end
    end
    scores
  end

  def overlaps
    scores.flatten.select { |score| score > 1 }.size
  end
end