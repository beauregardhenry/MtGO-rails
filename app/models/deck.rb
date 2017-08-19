class Deck < ApplicationRecord
  has_many :deck_archives
  has_many :cards, :through => :deck_archives

  KirdApeDeck = {:name => "Kird Apes", :description => "Apes to Your Face", :path => "./decks/KirdApes.deck"}
  SharedFateDeck = {:name => "Shared Fate", :description => "Shared Fate, Biznatch", :path => "./decks/SharedFate.deck"}
  AgelessEntityDeck = {:name => "Ageless Goblets", :description => "Ageless Entity to Your Face", :path => "./decks/AgelessGoblet.deck"}
  UntouchableEggsDeck = {:name => "Untouchable Eggs", :description => "Here, You Hold This...", :path => "./decks/UntouchableEggs.deck"}
  KirdApe2Deck = {:name => "Kird Apes", :description => "Apes to Your Face", :path => "./decks/KirdApes2.deck"}
  DeathCloudDeck = {:name => "Death Cloud", :description => "All Victory Are Belong To Me", :path => "./decks/DeathCloud.deck"}
  BurnDeck = {:name => "Burn Baby, Burn", :description => "Fire to Your Face", :path => "./decks/Burn.deck"}
  ScarabGod = {:name => "LOL. Nope.", :description => "Muhfuggin' Scarabs to Your Face", :path => "./decks/ScarabGod.deck"}
  DiscardDeck = {:name => "Discard", :description => "All Your Cards Are Belong to Me!!!", :path => "./decks/Discard.deck"}

  DeckIndex = {"1" => AgelessEntityDeck,
               "2" => KirdApeDeck,
               "3" => SharedFateDeck,
               "4" => UntouchableEggsDeck,
               "5" => KirdApe2Deck,
               "6" => DeathCloudDeck,
               "7" => BurnDeck,
               "8" => ScarabGod,
               "9" => DiscardDeck}

  def self.deck_selector(targetDeckID) # self makes this work
    return DeckIndex[targetDeckID] # return is how you get a value out of a function. very important. also stops execution. the return can be implicit, because Fucking Ruby.
  end # end def deck_selector

  def self.deck_sorter(selected_deck)
    deck_contents = IO.readlines(selected_deck[:path]) # where is the deck? Go over every line of the deck file
    deck = {'main_deck' => {}, 'sideboard' => {} } # main and sideboard are empty hashes, so how do i tell it I want {card_name: card_count} ?
    deck_location = 'main_deck'
    deck_contents.each do |line|
      line.strip!  # remove the whitespace from the ends of the lines
      parts = line.split(' ')
      card_count = parts.shift()
      card_name = parts.join(' ')
      if line == ""
        deck_location = 'sideboard'
        next
      end # end if
      deck[deck_location][card_name] = card_count
    end # end .each
    return deck
  end # end of def self.deck_sorter

  def self.add_api_query_to_deck(sorted_deck)
    augmented_deck = {'main_deck' => {}, 'sideboard' => {} }
    sorted_deck.each do |deck_location, subdeck| # took a long time to figure out what goes in the pipes
      subdeck.each do |card_name, card_count|
        api_data = MTG::Card.where(name: card_name).all
        augmented_deck[deck_location][card_name] = { 'count' => card_count, 'api_data' => api_data }
      end # end subdeck.each do
    end # end deck.each do
    return augmented_deck
  end # end self.add_api_query_to_deck

  def self.write_deck_to_database(sorted_deck)
    augmented_deck = Deck.add_api_query_to_deck(sorted_deck)
    augmented_deck.each do |deck_location, subdeck|
      subdeck.each do |card_name, card_details|
        card_details['api_data'].each do |card_data|
          Card.write_card_to_database(card_data)
        end # end card_details['api_data'].each
      end # end subdeck.each do
    end # end augmented_deck.each do
  end # end self.write_deck_to_database

  def self.get_from_sorted(sorted_deck)
    deck = {'main_deck' => {}, 'sideboard' => {} }
    sorted_deck.each do |deck_location, subdeck|
      subdeck.each do |card_name, card_count|
        card = Card.where(name: card_name).where.not(set_name: 'vanguard', image_url: nil).last
        deck[deck_location][card_name] = { 'count' => card_count, 'card' => card }
      end # end subdeck.each
    end # end deck.each
    return deck
  end # end self.get_from_sorted(sorted_deck)

=begin
      if card.hasImage?
        card_data = card
      else
        puts "Ain't no image for that card."
      end # if
    end # end card_query_results.each do
  end # end write_deck_to_database
=end

end # end class Deck
