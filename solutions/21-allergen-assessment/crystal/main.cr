
foods = File.read_lines("input.txt").map(&.tr("(,)", "")).to_h { |food|
	ingredients, allergens = food.split("contains").map(&.split)
	{ingredients, allergens}
}

allergens = foods.values.flatten.uniq
safe_ingrs = foods.keys.flatten.uniq

allergens_map = Hash(String, Array(String)).new

allergens.each do |allergen|
	allergen_foods = foods.select { |_, alrgs| alrgs.includes?(allergen) }
	nonsafe = allergen_foods.keys.reduce { |acc, a| acc & a }
	allergens_map[allergen] = nonsafe
	safe_ingrs -= nonsafe
end

safe_count = foods.keys.sum { |ingrs| (ingrs & safe_ingrs).size }

puts "Part 1 answer: #{safe_count}"

until allergens_map.values.all?(&.one?)
	identified = allergens_map.values.select(&.one?).flatten
	allergens_map.each do |allergen, ingrs|
		allergens_map[allergen] -= identified unless ingrs.one?
	end
end

allergen_ingrs = allergens_map.keys.sort.flat_map { |allergen|
	allergens_map[allergen]
}.join(",")

puts "Part 2 answer: #{allergen_ingrs}"
