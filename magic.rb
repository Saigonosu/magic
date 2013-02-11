# class Card
#   attr_accessor :name, :price
#   def initialize(name, price)
#     @name, @price = name, price
#   end
# end
#
# is equivalent to...
Card = Struct.new(:name, :price)


cardlist = Hash.new

price_list = File.new("./cards.csv", "r")

while (line = price_list.gets)
  name, price = line.split(",")
  price = price.to_f

  card = Card.new name, price

	cardlist[card.name] = card
end

total_price = 0.0

puts "Enter the name of the list you would like to tally"
file_path = gets.chomp
File.new(file_path, "r").each do |line|
  card_name = line.chomp

	puts card_name
	puts cardlist[card_name]

  card  = cardlist[card_name]
  price = card.price

	total_price += price
end

puts "The value of the collection is $#{total_price.round(2)}"
