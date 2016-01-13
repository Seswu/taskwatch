class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :taskname
      t.datetime :start
      t.datetime :stop
      t.boolean :active
      t.text :settings

      t.timestamps null: false
    end
  end
end
