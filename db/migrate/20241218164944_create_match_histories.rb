class CreateMatchHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :match_histories do |t|
      t.references :first_player, foreign_key: { to_table: :users }
      t.references :second_player, foreign_key: { to_table: :users }
      t.integer :first_player_points
      t.integer :second_player_points
      t.integer :first_player_elo
      t.integer :second_player_elo
      t.integer :elo_change
      t.references :winner, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
