class RemoveEndDateFromEvent < ActiveRecord::Migration[5.2]
  def change
    if column_exists? :events, :end_date
      remove_column :events, :end_date
    end
    unless column_exists? :events, :ticket_price
      add_column :events, :ticket_price, :decimal
    end
    add_column :events, :end_time, :datetime, after: :start_time
  end
end
