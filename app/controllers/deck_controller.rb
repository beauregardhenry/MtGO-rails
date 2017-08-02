require 'mtg_sdk'

class DeckController < ApplicationController
  def index
    @name = "Kird Apes"
    @description = "monkey to the face"
    # grab the deck from the disk
    contents = IO.readlines("/tmp/kird-apes.deck")
    location = 'main'
    @deck = {
      'main' => {},
      'sideboard' => {}
    }
    @stats = {
      'types' => {}
    }
    # go over every line of the deck file
    contents.each do |line|
      # remove the whitespace from the ends of the lines
      line.strip!
      if line == ""
        location = 'sideboard'
        next
      end
      parts = line.split(' ')
      card_count = parts.shift()
      card_name = parts.join(' ')

      card_data = MTG::Card.where(name: card_name).all.first
      (card_data.supertypes || []).each do |type|
        if @stats['types'].key? card_data.type
          @stats['types'][card_data.type] += 1
        else
          @stats['types'][card_data.type] = 1
        end
      end
      @deck[location][card_name] = {
        'count' => card_count,
        'data' => card_data
      }


    end

  end
end
