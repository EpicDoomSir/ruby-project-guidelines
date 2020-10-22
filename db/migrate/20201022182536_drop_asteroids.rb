class DropAsteroids < ActiveRecord::Migration[6.0]
  def change
    drop_table :asteroids
  end
end
