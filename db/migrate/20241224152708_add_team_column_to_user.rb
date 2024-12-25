class AddTeamColumnToUser < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :team, :string
  end

  def down
    remove_column :users, :team
  end
end
