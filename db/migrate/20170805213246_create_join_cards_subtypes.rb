class CreateJoinCardsSubtypes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cards, :subtypes do |t|
    end
  end
end
