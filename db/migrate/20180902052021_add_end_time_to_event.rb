class AddEndTimeToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :end_time, :datetime
    rename_column :events, :time, :start_time
  end
end
