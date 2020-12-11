
bag_rules = File.read_lines("input.txt").map(&.chomp("."))

BAG_TABLE = Hash(String, Hash(String, Int32)).new

bag_rules.each do |rule|
	bag, contents = rule.gsub(/( bag)s?/, "").split(" contain ")
	BAG_TABLE[bag] = contents.split(", ").map { |c|
		{c[2..], c[0].to_i} unless c == "no other"
	}.compact.to_h
end

def can_contain(target)
	bags = Set(String).new
	BAG_TABLE.each do |bag, contents|
		if contents[target]?
			bags << bag
			bags += can_contain(bag)
		end
	end
	return bags
end

def add_cost(bag)
	costs = 0
	BAG_TABLE[bag].each do |sub_bag, amount|
		costs += amount * add_cost(sub_bag)
	end
	return costs + 1
end

puts "Part 1 answer: #{can_contain("shiny gold").size}"
puts "Part 2 answer: #{add_cost("shiny gold") - 1}"
