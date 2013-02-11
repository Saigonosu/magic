cardlist = Hash.new

price_list = File.new("./cards.csv", "r")

while (line = price_list.gets)
	cardlist[line.split(",")[0]] = line.split(",")[1].to_f
end


price = 0.0

puts "Enter the name of the list you would like to tally"
x = gets.chomp
list = File.new(x, "r")

while(card = list.gets)
	puts card.chomp
	puts cardlist[card.chomp]
	price = price + cardlist[card.chomp]
end

puts "The value of the collection is $#{price.round(2)}"
