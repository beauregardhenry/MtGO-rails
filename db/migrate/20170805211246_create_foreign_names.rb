class CreateForeignNames < ActiveRecord::Migration[5.1]
  def change
    create_table :foreign_names do |t|
      t.string :name
      t.string :language
      t.integer :multiverse_id
      t.integer :card_id

      t.timestamps
    end
  end
end
