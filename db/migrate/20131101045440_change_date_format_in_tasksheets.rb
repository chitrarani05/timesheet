class ChangeDateFormatInTasksheets < ActiveRecord::Migration
  def self.up
    change_column :tasksheets, :date, :date
    change_column :tasksheets, :in_time, :time
    change_column :tasksheets, :out_time, :time
  end

  def self.down
    change_column :tasksheets, :date, :datetime
    change_column :tasksheets, :in_time, :datetime
    change_column :tasksheets, :out_time, :datetime
  end
end
