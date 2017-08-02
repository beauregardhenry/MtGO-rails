require 'mtg_sdk'

class DeckController < ApplicationController
  def index
    @name = "Ageless Goblet"
    @description = "Ageless Entity to the Face"

    # grab the deck from the disk
    contents = IO.readlines("AgelessGoblet.deck")
    location = 'main'

    @deck = {'main' => {}, 'sideboard' => {} }

    @stats = {'types' => {} }

    # go over every line of the deck file
    contents.each do |line|
      line.strip!  # remove the whitespace from the ends of the lines
      if line == ""
        location = 'sideboard'
        next
      end

      parts = line.split(' ')
      card_count = parts.shift()
      card_name = parts.join(' ')
      card_data = MTG::Card.where(name: card_name).all.first

      @deck[location][card_name] = { 'count' => card_count, 'data' => card_data }
    end
  end
end
