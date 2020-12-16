
rules, my_ticket, nearby = File.read("input.txt").split("\n\n").map(&.lines)

# less than ideal parsing
rules = rules.map { |rule|
	field, values = rule.split(":")
	values = values.split("or").map(&.split("-").map(&.to_i))
	ranges = values.map { |(min, max)| (min..max) }
	{field, ranges}
}.to_h
my_ticket = my_ticket[1].split(",").map(&.to_i64)
nearby    = nearby[1..].map(&.split(",").map(&.to_i))

invalid_vals = Array(Int32).new

nearby.flatten.each do |val|
	tests = rules.map { |_, ranges|
		ranges.map { |range|
			range.covers?(val)
		}.any?
	}
	invalid_vals << val unless tests.any?
end

puts "Part 1 answer: #{invalid_vals.sum}"

nearby.reject! { |ticket|
	ticket.map { |val|
		invalid_vals.includes?(val)
	}.any?
}

fields_map = Hash(String, Int32).new
candidates = rules.keys.map{ |field| {field, Array(Int32).new} }.to_h

rules.each do |field, ranges|
	(0...rules.size).each do |i|
		tests = nearby.map(&.[i]).map { |val|
			ranges.map { |range|
				range.covers?(val)
			}.any?
		}
		candidates[field] << i if tests.all?
	end
end

while fields_map.size < candidates.size
	candidates.each do |field, positions|
		if positions.size == 1
			pos = positions[0]
			fields_map[field] = pos
			candidates.values.map(&.delete(pos))
		end
	end
end

target_fields = rules.keys.select(&.starts_with?("departure"))
target_vals = target_fields.map { |field| my_ticket[fields_map[field]] }
puts "Part 2 answer: #{target_vals.product}"
