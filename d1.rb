file = 'd1.txt'
d1q1 = File.readlines(file).map(&:to_i).each_cons(2).select { |a,b| b > a }.size
d1q2 = File.readlines(file).map(&:to_i).each_cons(3).map(&:sum).each_cons(2).select { |a,b| b > a }.size
