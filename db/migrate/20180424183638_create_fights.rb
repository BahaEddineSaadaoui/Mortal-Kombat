class CreateFights < ActiveRecord::Migration[5.1]
  def change
    create_table :fights do |t|
      t.integer :winner_id
      t.integer :loser_id
      t.text :log

      t.timestamps
    end
  end
end
