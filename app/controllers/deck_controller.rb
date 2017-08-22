require 'mtg_sdk'

class DeckController < ApplicationController
  def index
    targetDeckID = "9"
    selected_deck = Deck.deck_selector(targetDeckID)
    sorted_deck = Deck.deck_sorter(selected_deck)
    augmented_deck = Deck.write_deck_to_database(sorted_deck, selected_deck)
    @name = selected_deck[:name]
    @description = selected_deck[:description]
    @deck = augmented_deck
  end # def index
end # class Deck_Controller
