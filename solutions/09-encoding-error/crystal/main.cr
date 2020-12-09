
data = File.read_lines("input.txt").map(&.to_i64)

preamble = data.shift(25)
vuln_num = 0

data.each do |num|
	checks = preamble.combinations(2).map{ |c| c.sum == num }
	if checks.none?
		vuln_num = num
		break
	end
	preamble.shift
	preamble << num
end

puts "Part 1 answer: #{vuln_num}"

sums = Hash(Int64, Int32).new
running_sum = 0_i64

data.each_with_index do |num, i|
	sums[running_sum] = i
	running_sum += num
	candidate = running_sum - vuln_num
	if sums[candidate]?
		puts "Part 2 answer: #{data[sums[candidate]..i].minmax.sum}"
		break
	end
end
