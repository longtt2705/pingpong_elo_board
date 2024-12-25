class AddUniquenessToUserName < ActiveRecord::Migration[8.0]
  def up
    add_index :users, :name, unique: true
  end

  def down
    remove_index :users, :name, unique: true
  end
end
