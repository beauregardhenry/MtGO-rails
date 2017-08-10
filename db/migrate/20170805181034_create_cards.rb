class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :multiverse_id
      t.string :layout
      t.string :mana_cost
      t.integer :cmc
      t.string :rarity
      t.string :text
      t.string :flavor
      t.string :artist
      t.integer :number
      t.string :power
      t.string :toughness
      t.integer :loyalty
      t.string :variations
      t.string :watermark
      t.string :border
      t.string :timeshifted
      t.string :hand
      t.integer :life
      t.string :reserved
      t.string :release_date
      t.string :starter
      t.string :original_text
      t.string :original_type
      t.string :source
      t.string :image_url
      t.string :set
      t.string :set_name
#      t.string :id # cannot use id, try again later

      t.timestamps
    end
  end
end
