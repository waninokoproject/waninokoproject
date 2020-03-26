class ChangeColumnToOkasis < ActiveRecord::Migration[5.1]
  def up
    add_column :okasis, :okasi_image, :string
    remove_column :okasis, :image_number, :integer
  end

  def down
    remove_column :okasis, :okasi_image, :string
    add_column :okasis, :image_number, :integer
  end
end
