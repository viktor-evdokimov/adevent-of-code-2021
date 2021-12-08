require 'set'

class Puzzle

  class Line
    attr_accessor :input, :output, :dict

    def initialize(input, output)
      @input = input
      @output = output
      @dict = {}
    end

    def build_dict
      by_size = input.group_by(&:size)

      one = by_size[2].first
      eight  = by_size[7].first
      four = by_size[4].first
      seven = by_size[3].first
      s6 = by_size[6]
      s5 = by_size[5]

      b_and_d = four - one
      a = seven - one
      five = s6.reduce(:&) | b_and_d
      c = four - five
      e = eight - five - one
      nine = eight - e
      six = eight - c
      s6.delete(nine)
      s6.delete(six)
      zero = s6.first
      s5.delete(five)
      two, three = s5.partition { |x| x & e == e }.map(&:first)

      dict[one] = "1"
      dict[two] = "2"
      dict[three] = "3"
      dict[four] = "4"
      dict[five] = "5"
      dict[six] = "6"
      dict[seven] = "7"
      dict[eight] = "8"
      dict[nine] = "9"
      dict[zero] = "0"
      dict["a"] = a
      dict["c"] = c
      dict["e"] = e
      dict["b and d"] = b_and_d
    end

    def mapped_output
      output.map(&dict).join.to_i(10)
    end
  end

  def self.parse(file)
    lines = File.readlines(file, chomp: true).
    map { |line| line.split(' | ') }.
    map do |input, output|
      Line.new(
        input.split(' ').map { |word| word.split('').to_set },
        output.split(' ').map { |word| word.split('').to_set }
      )
    end
    new(lines)
  end

  attr_reader :lines

  UNIQUE = {
    2 => 1,
    3 => 7,
    4 => 4,
    7 => 8
  }

  def initialize(lines)
    @lines = lines
  end

  def solve_pt1
    lines.flat_map { |line| line.output.select { |wires| UNIQUE.key?(wires.size) } }.size
  end

  def solve_pt2
    lines.each(&:build_dict)
    lines.map(&:mapped_output).sum
  end
end