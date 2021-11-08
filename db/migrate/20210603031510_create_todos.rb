class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.text :task, null: false
      t.datetime :duedate, null: false
      t.string :state, null: false, default: 'todo'
      t.timestamps
    end
  end
end
