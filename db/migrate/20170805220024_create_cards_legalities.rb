class CreateCardsLegalities < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cards, :legalities do |t|
    end
  end
end
