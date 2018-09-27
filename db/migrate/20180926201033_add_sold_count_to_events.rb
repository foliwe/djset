class AddSoldCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :sold_count, :integer, default: 0
    add_column :events, :images, :string, array: true, default: []
  end
end
