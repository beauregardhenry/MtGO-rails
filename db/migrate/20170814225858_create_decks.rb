class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :owner
      t.string :name
      t.string :description
      
      t.timestamps
    end
  end
end
