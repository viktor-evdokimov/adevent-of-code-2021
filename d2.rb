file = 'd2.txt'

def step(a, b)
  case a
    when 'forward'
      [0, b]
    when 'down'
      [b, 0]
    when 'up'
      [-b, 0]
  end
end

d2q1 = File.readlines(file).map{|s| s.split(' ')}.map{ |s| step(s[0], s[1].to_i) }.inject([0,0,0]) { |sum, a| sum.zip(a).map(&:sum) }

def move(pos, n)
  x, y, aim = pos
  daim, dx = n
  aim += daim
  x += dx
  y += dx * aim
  [x, y, aim]
end

d2q2 = File.readlines(file).map{|s| s.split(' ')}.map{ |s| step(s[0], s[1].to_i) }.inject([0,0,0]) { |pos, n| move(pos,n); }
