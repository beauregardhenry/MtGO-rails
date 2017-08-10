class CreateLegalities < ActiveRecord::Migration[5.1]
  def change
    create_table :legalities do |t|
      t.string :legality
      t.string :format

      t.timestamps
    end
  end
end
