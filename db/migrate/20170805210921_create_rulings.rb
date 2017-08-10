class CreateRulings < ActiveRecord::Migration[5.1]
  def change
    create_table :rulings do |t|
      t.date :date
      t.string :text
      t.integer :card_id

      t.timestamps
    end
  end
end
