class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :venue
      t.text :address
      t.string :special_guest

      t.timestamps
    end
  end
end
