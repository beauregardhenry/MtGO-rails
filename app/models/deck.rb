class Deck < ApplicationRecord
  has_many :deck_archives
  has_many :cards, :through => :deck_archives

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
