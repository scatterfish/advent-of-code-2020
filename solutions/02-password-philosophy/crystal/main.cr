
policies = File.read_lines("input.txt")

count_valid = 0
pos_valid = 0

policies.each do |entry|
	rules, code = entry.split(": ")
	range, letter = rules.split(" ")
	min, max = range.split("-").map(&.to_i)
	
	count_valid += 1 if min <= code.count(letter) <= max
	
	a, b = code[min - 1], code[max - 1]
	pos_valid += 1 if a != b && [a, b].includes?(letter[0])
end

puts "Part 1 answer: #{count_valid}"
puts "Part 2 answer: #{pos_valid}"
