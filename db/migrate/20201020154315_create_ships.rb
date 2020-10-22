class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :hp
      t.integer :scores
      t.integer :position, array: true
      t.string :direction
      t.integer :start_time
      
      t.timestamps
    end
    add_index :ships, :position, using: 'gin'
  end
end

