class Puzzle
  def self.parse(file, days)
    input = File.readlines(file, chomp: true).first.split(',').map(&:to_i)
    Puzzle.new(input, days)
  end

  attr_reader :input, :days

  def initialize(input, days)
    @counts = input.group_by(&:to_i).map { |k, v| [k, v.size] }
    @days = days
  end

  def next_day
    grow
    group
  end

  def grow
    @counts = @counts.flat_map do |pair|
      day, count = pair
      if day.zero?
        [[6, count], [8, count]]
      else
        [[day-1, count]]
      end
    end
  end

  def group
    @counts = @counts.group_by(&:first).map { |k, v| [k, v.map(&:last).sum] }
  end

  def solve
    @days.times { |i| next_day; puts "now #{i} #{ @counts.map(&:last).sum } lanterns" }
    @counts.map(&:last).sum
  end
end
