class ChangeTimeFormatInTasksheets < ActiveRecord::Migration
  def self.up
    change_column :tasksheets, :in_time, :datetime
    change_column :tasksheets, :out_time, :datetime
  end

  def self.down
    change_column :tasksheets, :in_time, :time
    change_column :tasksheets, :out_time, :time
  end
end
