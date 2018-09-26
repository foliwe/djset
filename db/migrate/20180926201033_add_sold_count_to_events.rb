class AddSoldCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :sold_count, :integer, default: 0
  end
end
