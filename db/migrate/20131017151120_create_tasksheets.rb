class CreateTasksheets < ActiveRecord::Migration
  def change
    create_table :tasksheets do |t|
      t.integer :client
      t.integer :project
      t.integer :activity_type
      t.text :task
      t.datetime :date 
      t.datetime :in_time
      t.datetime :out_time
      t.text :remark
      t.timestamps
    end
  end
end
