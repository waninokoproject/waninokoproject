class CreateOkasis < ActiveRecord::Migration[5.1]
  def change
    create_table :okasis do |t|
      t.string :name
      t.integer :price
      t.text :content
      t.string :okasi_attribute
      t.string :company

      t.timestamps
    end
  end
end
