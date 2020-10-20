class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :hp
      t.integer :scores
 
      t.timestamps
    end
  end
end
