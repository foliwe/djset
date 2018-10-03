class AddPosterImageToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :poster_image, :string
  end
end
