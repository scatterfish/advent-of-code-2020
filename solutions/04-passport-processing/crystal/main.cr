
def in_range?(field, range)
	return range.covers?(field.to_i)
end

passports = File.read("input.txt").strip.split("\n\n")

required_fields = %w(byr iyr eyr hgt hcl ecl pid)

has_fields = 0
valid_fields = 0

passports.each do |pass|
	fields = pass.split.map(&.split(":")).to_h
	next if (required_fields - fields.keys).any?
	has_fields += 1
	next unless in_range?(fields["byr"], (1920..2002))
	next unless in_range?(fields["iyr"], (2010..2020))
	next unless in_range?(fields["eyr"], (2020..2030))
	next unless fields["hcl"].matches?(/^#[0-9a-f]{6}$/)
	next unless fields["pid"].matches?(/^[0-9]{9}$/)
	next unless %w(amb blu brn gry grn hzl oth).includes?(fields["ecl"])
	next unless ["cm", "in"].any? { |u| fields["hgt"].ends_with?(u) }
	height_range = fields["hgt"].ends_with?("cm") ? (150..193) : (59..76)
	next unless in_range?(fields["hgt"][0..-3], height_range)
	valid_fields += 1
end

puts "Part 1 answer: #{has_fields}"
puts "Part 2 answer: #{valid_fields}"
