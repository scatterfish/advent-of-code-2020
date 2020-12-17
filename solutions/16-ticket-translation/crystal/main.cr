
rules, my_ticket, nearby = File.read("input.txt").split("\n\n").map(&.lines)

rules = rules.to_h { |rule| # don't try to read into this one
	vals = rule.scan(/(.+):|(\d+)-(\d+)/).compact_map(&.captures.compact)
	{vals.shift.first, vals.map(&.map(&.to_i)).map{ |(min, max)| min..max }}
}
tickets = (my_ticket + nearby).compact_map { |ticket|
	ticket.split(",").map(&.to_i64) unless ticket.matches?(/[a-z]/)
}

invalid_vals = Array(Int64).new

tickets.flatten.each do |val|
	tests = rules.values.map { |ranges|
		ranges.any?(&.covers?(val))
	}
	invalid_vals << val unless tests.any?
end

puts "Part 1 answer: #{invalid_vals.sum}"

tickets.reject! { |ticket| (ticket & invalid_vals).any? }

fields_map = Hash(String, Int32).new
candidates = rules.keys.to_h { |field| {field, Array(Int32).new} }

rules.each do |field, ranges|
	(0...rules.size).each do |i|
		tests = tickets.map(&.[i]).map { |val|
			ranges.any?(&.covers?(val))
		}
		candidates[field] << i if tests.all?
	end
end

while fields_map.size < candidates.size
	candidates.each do |field, positions|
		if positions.size == 1
			pos = positions.first
			fields_map[field] = pos
			candidates.values.each(&.delete(pos))
		end
	end
end

target_fields = rules.keys.select(&.starts_with?("departure"))
target_vals   = target_fields.map { |field| tickets.first[fields_map[field]] }

puts "Part 2 answer: #{target_vals.product}"
