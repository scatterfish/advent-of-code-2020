
# Crystal complains about ridiculously large regexes... but Ruby doesn't!

rules, messages = File.read("input.txt").split("\n\n").map(&:lines)

rules = rules.to_h { |rule|
	rule_id, params = rule.strip.split(": ")
	[rule_id.to_i, params.split("|").map{ |set| set.tr('"', "") }]
}

def build_regex(rules, rule_id, depth = 0)
	return "" if depth > 20
	rule = rules[rule_id]
	return rule[0] if rule[0].match(/[ab]/)
	match_str = rule.map { |set|
		set.split.map { |id|
			build_regex(rules, id.to_i, depth + 1)
		}.join
	}.join("|")
	return "(?:#{match_str})"
end

def validate_messages(rules, messages)
	match_rule = Regexp.new("^#{build_regex(rules, 0)}$")
	return messages.count { |message| message.match(match_rule) }
end

puts "Part 1 answer: #{validate_messages(rules, messages)}"

rules[8] = ["42", "42 8"]
rules[11] = ["42 31", "42 11 31"]

puts "Part 2 answer: #{validate_messages(rules, messages)}"
