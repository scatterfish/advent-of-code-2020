
passes = File.read_lines("input.txt", chomp: true)

seat_ids = Array(Int32).new

bin_map = {
	"F" => 0,
	"B" => 1,
	"L" => 0,
	"R" => 1,
}

passes.each do |pass|
	seat_ids << pass.gsub(/[FBLR]/, bin_map).to_i(2)
end

puts "Part 1 answer: #{seat_ids.max}"

0.step do |id|
	pair = [id - 1, id].map { |i| seat_ids.includes?(i) }
	if pair == [true, false]
		puts "Part 2 answer: #{id}"
		break
	end
end
