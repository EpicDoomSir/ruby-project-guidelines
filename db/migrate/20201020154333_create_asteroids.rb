class CreateAsteroids < ActiveRecord::Migration[6.0]
  def change
    create_table :asteroids do |t|
      t.integer :game_id
      t.integer :hp
      t.integer :size
 
      t.timestamps
    end
  end
end
