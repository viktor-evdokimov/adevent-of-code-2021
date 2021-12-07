require 'bigdecimal'

class Puzzle

  def self.parse(file)
    possitions = File.readlines(file).first.split(',').map(&:to_i)
    new(possitions)
  end

  attr_accessor :possitions, :possitions_mode

  def initialize(possitions)
    @possitions = possitions.sort
    @possitions_mode = median # pt 1
  end

  def solve_pt1
    possitions.map { |x| (x - possitions_mode).abs }.sum
  end

  def solve_pt2(offset)
    possitions.map do |x|
      steps = (x - offset).abs
      (steps + 1) * steps / 2
    end.sum
  end

  def solve_pt2_brute
    groupped = possitions.group_by(&:itself).transform_values(&:size)
    minimum = nil
    (0..groupped.keys.max).each do |x|
      current = solve_pt2(x)
      minimum = current if minimum.nil? || current < minimum
    end
    minimum
  end

  def median(offset=0)
    mid = (possitions.size / 2).to_i + offset
    possitions[mid]
  end
end