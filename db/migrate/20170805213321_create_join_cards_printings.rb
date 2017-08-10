class CreateJoinCardsPrintings < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cards, :printings do |t|
    end
  end
end
