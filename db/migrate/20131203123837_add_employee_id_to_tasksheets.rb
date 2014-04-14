class AddEmployeeIdToTasksheets < ActiveRecord::Migration
  def change
    add_column :tasksheets, :employee_id, :integer
  end
end
