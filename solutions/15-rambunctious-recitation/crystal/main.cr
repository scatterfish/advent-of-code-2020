
starting_numbers = File.read("input.txt").strip.split(",").map(&.to_i)

def play(numbers, count)
	spoken = numbers.map_with_index{ |num, i| {num, i + 1} }.to_h
	curr = numbers.last
	(numbers.size...count).each do |i|
		unless spoken[curr]?
			spoken[curr] = i
			curr = 0
		else
			temp = curr
			curr = i - spoken[curr]
			spoken[temp] = i
		end
	end
	return curr
end

puts "Part 1 answer: #{play(starting_numbers, 2020)}"
puts "Part 1 answer: #{play(starting_numbers, 30000000)}"
