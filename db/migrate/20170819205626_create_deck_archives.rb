class CreateDeckArchives < ActiveRecord::Migration[5.1]
  def change
    create_table :deck_archives do |t|
      t.integer :card_id
      t.integer :deck_id
      t.integer :main_count
      t.integer :sideboard_count

      t.timestamps
    end
  end
end
