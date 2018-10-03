class AddSoldCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :sold_count, :integer, default: 0
    add_column :events, :images, :text
    add_column :events, :ticket_image, :string
    # add_column :events, :images, :string, array: true, default: []
  end
end
