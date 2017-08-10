require 'mtg_sdk'

KirdApeDeck = {:name => "Kird Apes", :description => "Apes to Your Face", :path => "./decks/KirdApes.deck"}
SharedFateDeck = {:name => "Shared Fate", :description => "Shared Fate, Biznatch", :path => "./decks/SharedFate.deck"}
AgelessEntityDeck = {:name => "Ageless Goblets", :description => "Ageless Entity to Your Face", :path => "./decks/AgelessGoblet.deck"}
UntouchableEggsDeck = {:name => "Untouchable Eggs", :description => "Here, You Hold This...", :path => "./decks/UntouchableEggs.deck"}
KirdApe2Deck = {:name => "Kird Apes", :description => "Apes to Your Face", :path => "./decks/KirdApes2.deck"}
DeathCloudDeck = {:name => "Death Cloud", :description => "All Victory Are Belong To Me", :path => "./decks/DeathCloud.deck"}
BurnDeck = {:name => "Burn Baby, Burn", :description => "Fire to Your Face", :path => "./decks/Burn.deck"}
ScarabGod = {:name => "LOL. Nope.", :description => "Muhfuggin' Scarabs to Your Face", :path => "./decks/ScarabGod.deck"}

TargetDeck = "5"

Deck_index = {"1" => AgelessEntityDeck,
              "2" => KirdApeDeck,
              "3" => SharedFateDeck,
              "4" => UntouchableEggsDeck,
              "5" => KirdApe2Deck,
              "6" => DeathCloudDeck,
              "7" => BurnDeck,
              "8" => ScarabGod}

class DeckController < ApplicationController
  def index
    @name = Deck_index[TargetDeck][:name]
    @description = Deck_index[TargetDeck][:description]

    # grab the deck from the disk
    contents = IO.readlines(Deck_index[TargetDeck][:path])
    location = 'main'

    @deck = {'main' => {}, 'sideboard' => {} }

    @stats = {'types' => {} }

    # go over every line of the deck file
    contents.each do |line|
      line.strip!  # remove the whitespace from the ends of the lines
      if line == ""
        location = 'sideboard'
        next
      end # end if

      parts = line.split(' ')
      card_count = parts.shift()
      card_name = parts.join(' ')
      card_query_results = MTG::Card.where(name: card_name).all

      card_data = nil # where should this occur?

      card_query_results.each do |card_info| # reverse_each gives us the first copy of the card that meets criteria
        card = Card.write_card_to_database(card_info)
        # at this point you have replaced their card object (card_info) with your own (card). Good on you!

        if card.hasImage?
          card_data = card
        else
          puts "Ain't no fucking image for that damn card."
        end # if
      end

      @deck[location][card_name] = { 'count' => card_count, 'data' => card_data }
    end # .each
  end # def index
end # class Deck_Controller
