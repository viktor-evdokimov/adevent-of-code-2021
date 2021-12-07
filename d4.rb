class Bingo
  attr_reader :draw, :boards
  class Board
    attr_reader :lines, :scores
    def initialize(lines)
      @lines = lines.map { |line| line.split(' ').map(&:to_i) }
      @scores = 5.times.map { |i| 5.times.map { |j| 0 } }
    end

    def mark(number)
      @lines.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if cell == number
            @scores[i][j] = 1
          end
        end
      end
    end

    def final_score
      score = 0
      @lines.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if scores[i][j] == 0
            score += cell
          end
        end
      end
      score
    end

    def won?
      any_column_won? || any_row_won?
    end

    def any_column_won?
      @scores.transpose.any? { |r| r.sum == 5 }
    end

    def any_row_won?
      @scores.any? { |r| r.sum == 5 }
    end
  end

  # parse('d4.txt')
  # parse('d4_test.txt')
  def self.parse(file)
    lines = File.readlines(file, chomp:true)
    new(lines.first, lines.drop(1).each_slice(6).map{|s| s.drop(1)})
  end

  def initialize(draw, boards)
    @draw = draw.split(',').map(&:to_i)
    @boards = boards.map { |b| Board.new(b) }
  end

  # pt 1
  def find_winner
    draw.each_with_index do |number, round|
      boards.each_with_index do |board, board_number|
        board.mark(number)
        if board.won?
          puts "board #{board_number} won with score #{board.final_score} on number #{number} result = #{board.final_score * number}"
          return board.final_score * number
        end
      end
    end
  end

  # pt 2
  def find_last_winner
    draw.each_with_index do |number, round|
      boards.each_with_index do |board, board_number|
        board.mark(number)
        if boards.all?(&:won?)
          puts "board #{board_number} won with score #{board.final_score} on number #{number} result = #{board.final_score * number}"
          return board.final_score * number
        end
      end
    end
  end
end
