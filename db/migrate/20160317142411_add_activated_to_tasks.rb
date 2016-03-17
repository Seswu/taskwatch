class AddActivatedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :activated, :datetime
  end
end
