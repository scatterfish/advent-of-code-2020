
# who needs parsing when you have regex
# no recursion, no stack, no token indexing, no operator overloading

expressions = File.read_lines("input.txt")

def calc(expr, weird_math = false)
	if weird_math
		expr.scan(/\d+\s\+\s\d+/).map(&.[0]).each do |add_expr|
			lhs, _, rhs = add_expr.split
			ret_val = lhs.to_u64 + rhs.to_u64
			expr = expr.gsub(add_expr, ret_val)
		end
	end
	tokens = expr.split
	val = tokens.shift.to_u64
	until tokens.empty?
		op, rhs = tokens.shift(2)
		op == "+" ? (val += rhs.to_u64) : (val *= rhs.to_u64)
	end
	return val
end

normal_sum, weird_sum = 0_u64, 0_u64

expressions.each do |expr|
	until (most_nested = expr.scan(/\([\d\s+*]+\)/).map(&.[0])).empty?
		most_nested.each do |nested_expr|
			ret_val = calc(nested_expr.tr("()", ""))
			expr = expr.gsub(nested_expr, ret_val)
		end
	end
	normal_sum += calc(expr)
	weird_sum  += calc(expr, true)
end

puts "Part 1 answer: #{normal_sum}"
puts "Part 2 answer: #{weird_sum}"
