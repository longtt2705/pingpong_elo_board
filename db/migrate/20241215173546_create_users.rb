class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :elo
      t.integer :win_streak
      t.integer :total_match
      t.integer :total_win_match

      t.timestamps
    end
  end
end
