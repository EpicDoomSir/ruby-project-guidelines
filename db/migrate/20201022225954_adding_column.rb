class AddingColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :players, :integer
    add_column :games, :start_timer, :integer
    add_column :games, :started, :boolean
    add_column :games, :finish_flag, :integer
  end
end
