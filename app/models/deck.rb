class Deck < ApplicationRecord
  has_many :deck_archives
  has_many :cards, :through => :deck_archives

  KirdApeDeck = {:owner => "Beau", :name => "Kird Apes", :description => "Apes to Your Face", :path => "./decks/KirdApes.deck"}
  SharedFateDeck = {:owner => "Beau", :name => "Shared Fate", :description => "Shared Fate, Biznatch", :path => "./decks/SharedFate.deck"}
  AgelessEntityDeck = {:owner => "Beau", :name => "Ageless Goblets", :description => "Ageless Entity to Your Face", :path => "./decks/AgelessGoblet.deck"}
  UntouchableEggsDeck = {:owner => "Beau", :name => "Untouchable Eggs", :description => "Here, You Hold This...", :path => "./decks/UntouchableEggs.deck"}
  KirdApe2Deck = {:owner => "Beau", :name => "Kird Apes", :description => "Apes to Your Face", :path => "./decks/KirdApes2.deck"}
  DeathCloudDeck = {:owner => "Beau", :name => "Death Cloud", :description => "All Victory Are Belong To Me", :path => "./decks/DeathCloud.deck"}
  BurnDeck = {:owner => "Beau", :name => "Burn Baby, Burn", :description => "Fire to Your Face", :path => "./decks/Burn.deck"}
  ScarabGod = {:owner => "Beau", :name => "LOL. Nope.", :description => "Muhfuggin' Scarabs to Your Face", :path => "./decks/ScarabGod.deck"}
  DiscardDeck = {:owner => "Beau", :name => "Discard", :description => "All Your Cards Are Belong to Me!!!", :path => "./decks/Discard.deck"}
  ComebackRed = {:owner => "Beau", :name => "Comeback Red", :description => "Le Ouch to Your Face", :path => "./decks/ComebackRed.deck"}

  DeckIndex = {"1" => AgelessEntityDeck,
               "2" => KirdApeDeck,
               "3" => SharedFateDeck,
               "4" => UntouchableEggsDeck,
               "5" => KirdApe2Deck,
               "6" => DeathCloudDeck,
               "7" => BurnDeck,
               "8" => ScarabGod,
               "9" => DiscardDeck,
               "10" => ComebackRed}

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
      card_name = parts.join(' ').downcase
      if line == ""
        deck_location = 'sideboard'
        next
      end # end if
      deck[deck_location][card_name] = card_count
    end # end .each
    return deck
  end # end of def self.deck_sorter

  def self.write_deck_to_database(sorted_deck, deck_details)
    deck = Deck.find_or_create_by(:name => deck_details[:name])
    deck.update_attributes(
      :owner => deck_details[:owner],
      :description => deck_details[:description])
    deck.cards = []
    sorted_deck.each do |deck_location, subdeck|
      subdeck.each do |card_name, card_count|
        card = Card.where("lower(name) = ?", card_name.downcase).where.not(set_name: 'vanguard', image_url: nil).last
        if card.nil?
          puts "#{card_name} was not found in the database."
          # TODO: we should really tell the user about this error and not just skip the card
          next
        end
        unless deck.cards.include?(card)
          deck.cards << card # this is where the magic happens, once you have a deck and a card
        end # end unless deck.cards.include?
      end # end subdeck.each
    end # end sorted_deck.each
    deck.save
    deck.cards.each do |card|
      main_count = sorted_deck['main_deck'][card.name.downcase] || 0 # the || 0 avoids nil. cool stuff.
      sideboard_count = sorted_deck['sideboard'][card.name.downcase] || 0
      info = DeckArchive.where(:deck_id => deck.id, :card_id => card.id).first
      info.update_attributes(
        :main_count => main_count,
        :sideboard_count => sideboard_count )
      info.save
    end # end deck.cards.each do
    return deck
  end # end self.write_deck_to_database

  def main_deck()
    container = {}
    cards.each do |card|
      info = DeckArchive.where(:deck_id => id, :card_id => card.id).first
        if info.main_count > 0
          container[card] = info.main_count
        end # end if info.main_count
    end # end @cards.each do
    return container
  end # end main_dec

  def sideboard()
    container = {}
    cards.each do |card|
      info = DeckArchive.where(:deck_id => id, :card_id => card.id).first
        if info.sideboard_count > 0
          container[card] = info.sideboard_count
        end # end if info.sideboard
    end # end @cards.each do
    return container
  end # end sideboard

end # end class Deck
