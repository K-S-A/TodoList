class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string      :title,       null: false
      t.string      :description
      t.references  :user,        null: false, index: true, foreign_key: true

      t.timestamps                null: false
    end

    add_index :projects, [:user_id, :title], unique: true
  end
end
