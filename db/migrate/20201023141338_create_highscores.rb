class CreateHighscores < ActiveRecord::Migration[6.0]
  def change
    create_table :highscores do |t|
      t.integer :user_id
      t.integer :game_id
      t.float :score
    end
  end
end
