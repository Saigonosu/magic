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
    
    def self.where_name_matches(str)
      cards = Magic.cards.select {|card_name, card| card_name.match(/^#{str}/)}
    end
  end
end

# generate all Magic::Card
File.new("./cards.csv", "r").each do |line|
  Magic::Card.create_from_line_of_csv(line)
end

def prompt_user_to_reenter_card_name_for_card(str)
  print "Card \"#{str}\" not found, please enter card name: "
  gets.chomp
end

def prompt_user_to_select_card_from_cards(cards)
  puts "Please select a card from the list"
  num, cards_arr = 1, []
  cards.each do |card_name, card|
    cards_arr << card

    puts "#{"%2s" % num}: #{card_name}"

    num += 1
  end

  num = gets.to_i - 1

  card = if 1 <= num && num <= cards.size
    cards_arr[num]
  else
    prompt_user_to_select_card_from_cards(cards)
  end
end

total_price = 0.0

puts "Enter the name of the list you would like to tally"
file_path = gets.chomp
File.new(file_path, "r").each do |line|
  card_name = line.chomp
  cards = Magic::Card.where_name_matches(card_name)

  while cards.empty?
    card_name = prompt_user_to_reenter_card_name_for_card(card_name)
    cards = Magic::Card.where_name_matches(card_name)
  end

  if cards.size == 1
    card = cards.values.first
  else
    card = prompt_user_to_select_card_from_cards(cards)
  end

  price = card.price

	puts card.name, card.price

	total_price += price
end

puts "The value of the collection is $#{total_price.round(2)}"
