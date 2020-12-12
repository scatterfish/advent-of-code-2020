
nav_commands = File.read_lines("input.txt").map{ |c| {c[0], c[1..].to_i} }

class Coords
	property east, north
	def initialize(@east : Int32, @north : Int32)
	end
	def rotate(dir, val)
		while val > 0
			if dir == 'L'
				@east, @north = -@north, @east
			else
				@east, @north = @north, -@east
			end
			val -= 90
		end
	end
	def distance()
		@east.abs + @north.abs
	end
end

simple_coords  = Coords.new(0, 0)
complex_coords = Coords.new(0, 0)
waypoint       = Coords.new(10, 1)

dir = 90
dir_map = {
	0   => 'N',
	90  => 'E',
	180 => 'S',
	270 => 'W',
}

def nesw(dir, val, coords)
	case dir
	when 'N'; coords.north += val
	when 'S'; coords.north -= val
	when 'E'; coords.east  += val
	when 'W'; coords.east  -= val
	end
end

nav_commands.each do |(command, param)|
	case command
	when 'N', 'E', 'S', 'W'
		[simple_coords, waypoint].each { |c| nesw(command, param, c) }
	when 'F'
		nesw(dir_map[dir % 360], param, simple_coords)
		complex_coords.east  += waypoint.east  * param
		complex_coords.north += waypoint.north * param
	when 'L', 'R'
		waypoint.rotate(command, param)
		param = -param if command == 'L'
		dir += param
	end
end

puts "Part 1 answer: #{simple_coords.distance}"
puts "Part 2 answer: #{complex_coords.distance}"
