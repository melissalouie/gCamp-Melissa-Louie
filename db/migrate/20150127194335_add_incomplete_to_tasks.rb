class AddIncompleteToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :incomplete, :boolean
  end
end
