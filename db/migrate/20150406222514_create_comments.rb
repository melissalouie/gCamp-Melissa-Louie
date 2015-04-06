class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.belongs_to :user, index: true
    end
    add_foreign_key :comments, :users
  end
end
