
report = File.read_lines("input.txt").map(&.to_i)

[2, 3].each do |count|
	report.each_combination(count) do |combi|
		if combi.sum == 2020
			puts "Part #{count - 1} answer: #{combi.product}"
			break
		end
	end
end
