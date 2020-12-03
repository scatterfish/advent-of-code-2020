
terrain = File.read_lines("input.txt", chomp: true).map(&.chars)

slopes = [
	{x: 3, y: 1},
	{x: 1, y: 1},
	{x: 5, y: 1},
	{x: 7, y: 1},
	{x: 1, y: 2},
]

tree_counts = Array(Int64).new

slopes.each do |slope|
	x_pos, y_pos, trees = 0, 0, 0_i64
	while y_pos < terrain.size
		trees += 1 if terrain[y_pos][x_pos] == '#'
		x_pos += slope[:x]
		x_pos %= terrain[y_pos].size
		y_pos += slope[:y]
	end
	tree_counts << trees
end

puts "Part 1 answer: #{tree_counts[0]}"
puts "Part 2 answer: #{tree_counts.product}"
