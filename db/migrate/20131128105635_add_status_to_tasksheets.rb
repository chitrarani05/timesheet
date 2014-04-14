class AddStatusToTasksheets < ActiveRecord::Migration
  def change
    add_column :tasksheets, :status, :string, :default => "new"
  end
end
