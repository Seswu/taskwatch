class AddSessionToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :session, index: true, foreign_key: true
  end
end
