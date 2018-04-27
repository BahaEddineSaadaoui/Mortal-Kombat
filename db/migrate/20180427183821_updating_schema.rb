class UpdatingSchema < ActiveRecord::Migration[5.1]
  def change
  	remove_column :fighters, :is_fighting
  	remove_column :fighters, :progress_id
  	add_column :fights, :winner_score, :integer
  	add_column :fights, :loser_score, :integer
  	drop_table :progresses
  	drop_table :progressweapons
  end
end
