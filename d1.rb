file = 'd1.txt'
d1q1 = File.readlines(file).map(&:to_i).each_cons(2).select { |a,b| b > a }.size
d1q2 = File.readlines(file).map(&:to_i).each_cons(3).map(&:sum).each_cons(2).select { |a,b| b > a }.size


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



# d3q1 =
File.readlines(file, chomp:true).map{|s| s.split('')}.take(5)

counters = _.first.map { |_| { "0" => 0, "1" => 0 } }

File.readlines(file, chomp:true).map{|s| s.split('')}.each do |a|
  a.each_with_index do |v, index|
    counters[index][v] += 1
  end
end

n1 = "110001011000".to_i(2)
n2 = "001110100111".to_i(2)
3160 * 935


# d3q2 =

def search(array, func)
  bit = 0
  while array.size > 1
    counter = count_bits(array, bit)
    filter_value = func.call(counter)
    array = array.select { |a| a[bit] == filter_value }
    bit += 1
  end
  array.first
end

def count_bits(array, bit)
  counter = { "0" => 0, "1" => 0 }
  array.each do |a|
    counter[a[bit]] += 1
  end
  counter
end

def min_func(counter)
  if counter["0"] < counter["1"]
    "0"
  elsif counter["1"] < counter["0"]
    "1"
  else
    "0"
  end
end

def max_func(counter)
  if counter["0"] > counter["1"]
    "0"
  elsif counter["1"] > counter["0"]
    "1"
  else
    "1"
  end
end
