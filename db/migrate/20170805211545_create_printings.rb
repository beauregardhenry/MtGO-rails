class CreatePrintings < ActiveRecord::Migration[5.1]
  def change
    create_table :printings do |t|
      t.string :set

      t.timestamps
    end
  end
end
