class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
    end
    add_foreign_key :members, :projects
    add_foreign_key :members, :users
  end
end
