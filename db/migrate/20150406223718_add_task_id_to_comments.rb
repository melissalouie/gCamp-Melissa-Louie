class AddTaskIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :task, index: true
    add_foreign_key :comments, :tasks
  end
end
