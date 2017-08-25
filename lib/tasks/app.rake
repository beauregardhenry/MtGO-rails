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

DECKS = [ AgelessEntityDeck, KirdApeDeck, SharedFateDeck, UntouchableEggsDeck, KirdApe2Deck, DeathCloudDeck, BurnDeck, ScarabGod, DiscardDeck, ComebackRed ]


def read_deck(path)
  deck_contents = IO.readlines(path) # where is the deck? Go over every line of the deck file
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
end # end read_deck

namespace :app do
  desc "TODO"
  task import_decks: :environment do
    DECKS.each do |deck|
      sorted_deck = read_deck(deck[:path])
      puts "Attempting to store #{deck[:name]}"
      Deck.write_deck_to_database(sorted_deck, deck)
      puts "Stored #{deck[:name]}"
    end
  end
end
