
program = File.read_lines("input.txt").map(&.split)

def exec(instructions)
	ip, acc = 0, 0
	known_ip = Set(Int32).new
	loop do
		if known_ip.includes?(ip) || ip == instructions.size
			return ip, acc
		end
		known_ip << ip
		op, val = instructions[ip]
		val = val.to_i
		case op
		when "acc"
			acc += val
		when "jmp"
			ip += val - 1
		end
		ip += 1
	end
end

ip, acc = exec(program)
puts "Part 1 answer: #{acc}"

edit_map = {
	"acc" => "acc",
	"jmp" => "nop",
	"nop" => "jmp",
}

edit_ip = 0
loop do
	program_edit = program.dup
	op_edit, val = program_edit[edit_ip]
	program_edit[edit_ip] = [edit_map[op_edit], val]
	ip, acc = exec(program_edit)
	if ip == program.size
		puts "Part 2 answer: #{acc}"
		break
	end
	edit_ip += 1
end
