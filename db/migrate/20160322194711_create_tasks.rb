class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string      :name,      null: false
      t.references  :project,   null: false, index: true, foreign_key: true
      t.boolean     :completed, default: false
      t.date        :deadline

      t.timestamps null: false
    end

    add_index :tasks, [:project_id, :name], unique: true
  end
end
