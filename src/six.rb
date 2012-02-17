def tweeter(line)
	line.match(/^(\w+)/)[0]
end

def tweeties(line)
	array = []
	line.scan(/[@](\w+)/).each { |name| array << name[0] }
	array
end

def mentions(line)
	speaker = tweeter(line)
	array = []
	tweeties(line).each { |name| array << [speaker,name] }
	array
end

def add_mentions(line, existing_mentions)
	new_mentions = mentions(line)
	
	new_mentions.each do |mention|
		unless existing_mentions.index(mention)
			existing_mentions << mention
		end
	end
	existing_mentions
end

def map_first_order_relationships(mentions)
	array = []
	mentions.each do |k|
		inverse = [k[1],k[0]]
		if mentions.index(inverse)
			array << k
		end
	end
	array
end
