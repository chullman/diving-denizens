class CreateDeliveryAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_addresses do |t|
      t.references :address, null: false, foreign_key: true
      t.bigint :cart_num

      t.timestamps
    end
  end
end
