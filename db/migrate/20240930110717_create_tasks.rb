class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_title
      t.integer :user_id
      t.datetime :working_hours
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
