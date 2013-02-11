module Magic
  @@cards = {}

  def self.cards
    @@cards
  end

  def @@cards.<<(card)
    @@cards[card.name] = card
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
end

# generate all Magic::Card
File.new("./cards.csv", "r").each do |line|
  Magic::Card.create_from_line_of_csv(line)
end

total_price = 0.0

puts "Enter the name of the list you would like to tally"
file_path = gets.chomp
File.new(file_path, "r").each do |line|
  card_name = line.chomp

  card  = Magic.cards[card_name]
  price = card.price

	puts card.name, card.price

	total_price += price
end

puts "The value of the collection is $#{total_price.round(2)}"
