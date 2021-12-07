
# d3q1 =
File.readlines(file, chomp:true).map{|s| s.split('')}.take(5)

counters = _.first.map { |_| { "0" => 0, "1" => 0 } }

File.readlines(file, chomp:true).map{|s| s.split('')}.each do |a|
  a.each_with_index do |v, index|
    counters[index][v] += 1
  end
end

# n1 = "110001011000".to_i(2)
# n2 = "001110100111".to_i(2)
# 3160 * 935


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
