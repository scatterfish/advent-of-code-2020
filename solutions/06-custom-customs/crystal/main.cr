
groups = File.read("input.txt").strip.split("\n\n").map(&.split.map(&.chars))

any_questions = groups.map(&.flatten.uniq.size).sum
all_questions = groups.map(&.reduce{ |acc, q| acc & q }.size).sum

puts "Part 1 answer: #{any_questions}"
puts "Part 2 answer: #{all_questions}"
