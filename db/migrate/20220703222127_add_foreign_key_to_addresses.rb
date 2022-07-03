class AddForeignKeyToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_index :postcodes, :postcode, unique: true
    add_foreign_key :addresses, :postcodes, column: :postcode_id, primary_key: :postcode
  end
end
