class AddReasonToTasksheets < ActiveRecord::Migration
  def change
    add_column :tasksheets, :reason, :text
  end
end
