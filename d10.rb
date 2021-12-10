class Puzzle

  def self.parse(file)
    lines = File.readlines(file, chomp: true).map { |line| line.split('') }
    new(lines)
  end

  attr_reader :lines

  OPEN = [ '<', '(', '{', '[' ]
  CLOSE = [ '>', ')', '}', ']' ]

  MATCH = {
    ')' => '(',
    ']' => '[',
    '}' => '{',
    '>' => '<',
  }

  CLOSE_MATCH = {
    '('=>')',
    '['=>']',
    '{'=>'}',
    '<'=>'>',
  }

  SCORES_ERRORS = {
    ')'=> 3,
    ']'=> 57,
    '}'=> 1197,
    '>'=> 25137,
  }

  SCORES_COMPLETE = {
    ')'=> 1,
    ']'=> 2,
    '}'=> 3,
    '>'=> 4,
  }

  def initialize(lines)
    @lines = lines
  end

  def first_corrupted_char(line)
    stack = []
    line.each do |char|
      if OPEN.include?(char)
        stack << char
      elsif CLOSE.include?(char)
        last = stack.pop
        if MATCH[char] != last
          return char
        end
      end
    end
    return nil
  end

  def remainder(line)
    stack = []
    line.each do |char|
      if OPEN.include?(char)
        stack << char
      elsif CLOSE.include?(char)
        last = stack.pop
        if MATCH[char] != last
          return nil
        end
      end
    end
    stack
  end

  def solve_pt1
    lines.
    map(&method(:first_corrupted_char)).
    compact.
    map(&SCORES_ERRORS).
    sum
  end

  def solve_pt2
    pt2_scores = lines.map(&method(:remainder)).
    compact.
    map do |line|
      line.
      map(&CLOSE_MATCH).
      map(&SCORES_COMPLETE).
      reverse.
      inject(0) { |sum, n| sum * 5 + n }
    end.
    sort

    pt2_scores[pt2_scores.size/2]
  end
end