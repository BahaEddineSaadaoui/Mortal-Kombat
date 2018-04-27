class AddFighterIdToProgress < ActiveRecord::Migration[5.1]
  def change
  	add_column :progresses, :fighter_id, :integer
  end
end
