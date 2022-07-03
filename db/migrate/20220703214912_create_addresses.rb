class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :unit_type
      t.integer :unit_num
      t.string :lvl_type
      t.integer :lvl_num
      t.string :street_type
      t.integer :street_num
      t.string :street_name
      t.string :suburb

      t.timestamps
    end
  end
end
