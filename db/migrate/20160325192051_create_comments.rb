class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string      :body,      null: false
      t.string      :file_link
      t.references  :task,      null: false, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :comments, [:task_id, :body], unique: true
  end
end
