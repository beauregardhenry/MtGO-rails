require 'mtg_sdk'

class DeckController < ApplicationController
  def index
    targetDeckID = "8"
    selected_deck = Deck.deck_selector(targetDeckID)
    sorted_deck = Deck.deck_sorter(selected_deck)
    Deck.write_deck_to_database(sorted_deck)
    augmented_deck = Deck.get_from_sorted(sorted_deck)
    @name = selected_deck[:name]
    @description = selected_deck[:description]
    @deck = augmented_deck
  end # def index
end # class Deck_Controller
