class RenameTasksheets < ActiveRecord::Migration
  def change
    change_table :tasksheets do |t|
      t.rename :client, :client_id
      t.rename :project, :project_id
      t.rename :activity_type, :activity_type_id
    end
  end
end
