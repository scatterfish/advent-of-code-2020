require "uri"

start_time, schedule = File.read_lines("input.txt")
start_time = start_time.to_i
busses = schedule.split(",").map_with_index { |bus, i|
	{bus.to_i, i} unless bus == "x"
}.compact

bus_times = busses.map { |bus, _|
	{bus, ((start_time // bus) + 1) * bus - start_time}
}
first_bus, wait_time = bus_times.min_by { |bus, time| time }

puts "Part 1 answer: #{first_bus * wait_time}"

# This is Advent of Code, not Project Euler.
# WolframAlpha to the rescue. I don't feel even a smidge of guilt.
query = ""
busses.each do |bus, i|
	query += "(t+#{i})mod#{bus}=0,"
end

puts "Part 2 answer:"
puts "https://wolframalpha.com/input?i=" + URI.encode(query, space_to_plus: true)
puts "The solution is in y=mx+b form, and the answer is b."
