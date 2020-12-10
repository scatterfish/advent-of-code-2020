
ratings = File.read_lines("input.txt").map(&.to_i64)
ratings << 0
ratings << ratings.max + 3
ratings.sort!

deltas = Hash(Int64, Int32).new(0)

ratings.each_cons(2) do |(a, b)|
	deltas[b - a] += 1
end

puts "Part 1 answer: #{deltas[1] * deltas[3]}"

PATH_COUNTS = Hash(Int64, Int64).new
PATH_COUNTS[0] = 1

def count_paths(joltages, rating)
	count = 0_i64
	joltages.each do |jolt|
		if rating - 3 <= jolt < rating
			unless PATH_COUNTS[jolt]?
				PATH_COUNTS[jolt] = count_paths(joltages, jolt)
			end
			count += PATH_COUNTS[jolt]
		end
	end
	return count
end

puts "Part 2 answer: #{count_paths(ratings, ratings.max)}"
