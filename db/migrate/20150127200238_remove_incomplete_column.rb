class RemoveIncompleteColumn < ActiveRecord::Migration
  def change
    remove_column :tasks, :incomplete, :boolean
  end
end
