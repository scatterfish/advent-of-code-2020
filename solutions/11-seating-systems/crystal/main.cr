
# I hate this.

seats = File.read_lines("input.txt").map(&.chars)

DIR_MAP = {
	:left      => {-1,  0},
	:right     => { 1,  0},
	:up        => { 0, -1},
	:down      => { 0,  1},
	:upleft    => {-1, -1},
	:upright   => {-1,  1},
	:downleft  => { 1, -1},
	:downright => { 1,  1},
}

def see(row, col, dir, seats, nearsighted)
	dir_row, dir_col = DIR_MAP[dir]
	see_row = row + dir_row
	see_col = col + dir_col
	while (0...seats.size).covers?(see_row) && (0...seats[row].size).covers?(see_col)
		if seats[see_row][see_col] != '.' || nearsighted
			return seats[see_row][see_col]
		end
		see_row += dir_row
		see_col += dir_col
	end
	return '.'
end

[4, 5].each do |threshold|
	count = 0
	prev_count = -1
	seats_curr = seats.clone
	until count == prev_count
		prev_count = count
		seats_next = seats_curr.clone
		seats.size.times do |row|
			seats[row].size.times do |col|
				adj_seats = DIR_MAP.keys.map { |dir| see(row, col, dir, seats_curr, threshold == 4) }
				case seats_curr[row][col]
				when 'L'
					seats_next[row][col] = '#' if adj_seats.count('#') == 0
				when '#'
					seats_next[row][col] = 'L' if adj_seats.count('#') >= threshold
				end
			end
		end
		seats_curr = seats_next
		count = seats_curr.map(&.count('#')).sum
	end
	puts "Part #{threshold - 3} answer: #{count}"
end
