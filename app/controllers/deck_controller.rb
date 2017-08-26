require 'mtg_sdk'

class DeckController < ApplicationController
  def index
    @deck = Deck.find(params[:id])
  end # def index
end # class Deck_Controller
