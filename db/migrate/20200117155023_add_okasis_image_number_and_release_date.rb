class AddOkasisImageNumberAndReleaseDate < ActiveRecord::Migration[5.1]
  def change
    add_column :okasis, :image_number, :integer

    add_column :okasis, :release_date, :date
  end
end
