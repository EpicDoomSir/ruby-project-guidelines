class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :hp
      t.integer :scores
      t.integer :position_x
      t.integer :position_y
      t.string :direction
      t.integer :start_time
      t.integer :player_option
      t.timestamps
    end
  end
end

