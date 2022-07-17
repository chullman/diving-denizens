class CreateDeliveryFees < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_fees do |t|
      t.decimal :fee_price

      t.timestamps
    end
  end
end
