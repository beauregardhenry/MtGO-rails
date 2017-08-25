require 'mtg_sdk'

class DeckController < ApplicationController
  def index
    id = 4 # get this value from the decks table, for now
    selected_deck = Deck.find(id)
    @name = selected_deck.name
    @description = selected_deck.description
    @deck = selected_deck
  end # def index
end # class Deck_Controller
