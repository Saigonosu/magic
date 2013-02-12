module Magic
  @@cards = {}
  @@fullcard = {}

  def self.cards
    @@cards
  end

  def self.fullcard
	@@fullcard
  end

  def @@cards.<<(card)
    @@cards[card.name] = card
  end

  def @@fullcard.<<(card)
    @@fullcard[card.name] = card
  end

  # class Card
  #   attr_accessor :name, :price
  #   def initialize(name, price)
  #     @name, @price = name, price
  #   end
  # end
  #
  # is equivalent to...
  Card = Struct.new(:name, :price) do
    def self.create_from_line_of_csv(csv_line)
      name, price = csv_line.split(",")
      price = price.to_f

      card = self.new name, price

      Magic.cards << card
    end
  end

	FullCard = Struct.new(:name, :set, :rarity, :cost, :pt, :type, :text, :flavor) do
	def self.create_from_line_of_csv(full_list)
     name, set, rarity, cost, pt, type, text, flavor = full_list.split("\t")
     card = self.new name, set, rarity, cost, pt, type, text, flavor
     Magic.fullcard << card
    end
	
	def self.card_search
    puts "Card name?"
    card_name = gets.chomp
	puts Magic.fullcard[card_name]
	end
end
end

#---------------------------------------------------------------------

# generate all Magic::Card
File.new("./cards.csv", "r").each do |line|
  Magic::Card.create_from_line_of_csv(line)
end

# generate all full Magic::FullCard
File.new("./Master.csv", "r").each do |line|
  Magic::FullCard.create_from_line_of_csv(line)
end

total_price = 0.0

Magic::FullCard.card_search

puts "Enter the name of the list you would like to tally"
file_path = gets.chomp
File.new(file_path, "r").each do |line|
  card_name = line.chomp

  card  = Magic.cards[card_name]
  fullcard = Magic.fullcard[card_name]
  price = card.price

	puts card.name, card.price, fullcard.set, fullcard.rarity, fullcard.cost, fullcard.pt, fullcard.type, fullcard.text

	total_price += price
end

puts "The value of the collection is $#{total_price.round(2)}"
