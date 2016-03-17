class AddSessionToLogs < ActiveRecord::Migration
  def change
    add_reference :logs, :session, index: true, foreign_key: true
  end
end
