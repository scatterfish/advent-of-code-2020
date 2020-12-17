
starting_grid = File.read_lines("input.txt").map(&.chars.map{ |c| c == '#' })

starting_cubes = Set(Array(Int32)).new

(0...starting_grid.size).each do |row|
	(0...starting_grid[row].size).each do |col|
		starting_cubes << [col, row, 0, 0] if starting_grid[row][col]
	end
end

def simulate(cubes, dim)
	deltas = [-1, 0, 1].repeated_permutations(dim).compact_map { |delta|
		delta << 0 if dim == 3
		delta unless delta.all?(0)
	}
	6.times do
		neighbors = Hash(Array(Int32), Int32).new(0)
		cubes.each do |coords|
			deltas.each do |delta|
				neighbor = coords.zip(delta).map { |a, b| a + b }
				neighbors[neighbor] += 1
			end
		end
		cubes = cubes.select { |coords|
			(2..3).covers?(neighbors[coords])
		}.to_set
		neighbors.each do |coords, count|
			cubes << coords if count == 3
		end
	end
	return cubes.size
end

puts "Part 1 answer: #{simulate(starting_cubes, 3)}"
puts "Part 2 answer: #{simulate(starting_cubes, 4)}"
