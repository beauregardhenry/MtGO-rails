class CreateJoinCardsSupertypes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cards, :supertypes do |t|
    end
  end
end
