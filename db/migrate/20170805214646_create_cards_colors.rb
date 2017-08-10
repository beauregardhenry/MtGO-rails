class CreateCardsColors < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cards, :colors do |t|
    end
  end
end
