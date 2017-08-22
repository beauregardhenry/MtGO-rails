class CreateDeckArchives < ActiveRecord::Migration[5.1]
  def change
    create_table :deck_archives do |t|
      t.belongs_to :deck, index: true
      t.belongs_to :card, index: true
      t.integer :main_count
      t.integer :sideboard_count

      t.timestamps
    end
  end
end
