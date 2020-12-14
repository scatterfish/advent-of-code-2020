
program = File.read_lines("input.txt")

float_mask = Array(Int32).new
bit_mask = Hash(UInt64, Int32).new
memory_1 = Hash(UInt64, UInt64).new
memory_2 = Hash(UInt64, UInt64).new

def set_bit(val, i, bit)
	bit == 1 ? (val | (1_u64 << i)) : (val & ~(1_u64 << i))
end

program.each do |line|
	if line.starts_with?("mask")
		mask = line[7..].chars.reverse.zip(0...36)
		bit_mask   = mask.compact_map { |b, i| {b.to_u64, i} unless b == 'X'}
		float_mask = mask.compact_map { |b, i| i if b == 'X' }
	else
		addr, val = line.scan(/[0-9]+/).map(&.[0].to_u64)
		addr_masked, val_masked = addr, val
		
		bit_mask.each do |bit, i|
			val_masked  = set_bit(val_masked, i, bit)
			addr_masked = set_bit(addr_masked, i, 1) if bit == 1
		end
		memory_1[addr] = val_masked
		
		addr_list = [0, 1].repeated_permutations(float_mask.size).map { |perm|
			perm.each_with_index do |bit, i|
				addr_masked = set_bit(addr_masked, float_mask[i], bit)
			end
			addr_masked
		}
		addr_list.each do |addr_floating|
			memory_2[addr_floating] = val
		end
	end
end

puts "Part 1 answer: #{memory_1.values.sum}"
puts "Part 2 answer: #{memory_2.values.sum}"
