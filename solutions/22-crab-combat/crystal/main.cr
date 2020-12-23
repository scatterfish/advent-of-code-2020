
start = File.read("input.txt").split("\n\n").map(&.lines[1..].map(&.to_i64))

def combat(decks, recursive)
	seen = Set(UInt64).new
	until decks.any?(&.empty?)
		return true if decks.any? { |deck| seen.includes?(deck.hash) }
		decks.each { |deck| seen << deck.hash }
		hands = decks.map(&.shift)
		cards = decks.zip(hands)
		if recursive && cards.all? { |deck, hand| deck.size >= hand }
			sub_decks = cards.map { |deck, hand| deck[...hand] }
			winner = combat(sub_decks, true)
		else
			winner = hands[0] > hands[1]
		end
		decks[winner ? 0 : 1] += (winner ? hands : hands.reverse)
	end
	return decks[0].any?
end

[1, 2].each do |part|
	decks = start.clone
	combat(decks, part == 2)
	cards = decks.flatten.reverse
	score = cards.map_with_index{ |card, i| card * (i + 1) }.sum
	puts "Part #{part} answer: #{score}"
end
